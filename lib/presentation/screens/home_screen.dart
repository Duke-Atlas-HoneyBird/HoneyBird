import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/injection.dart';
import '../../core/utils/snackbar_utils.dart';
import '../../application/use_cases/post/get_posts.dart';
import '../../application/use_cases/post/like_post.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../state/auth/auth_bloc.dart';
import '../state/auth/auth_state.dart';
import '../theme/colours.dart';
import '../theme/constants.dart';
import '../theme/text_styles.dart';
import '../theme/spacing.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/post_feed_widget.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/side_menu_drawer.dart';
import 'post_creation_screen.dart';

/// The main home screen of the HoneyBird app
/// 
/// Displays a gradient background, search bar, post feed, bottom navigation,
/// and provides access to the side menu and post creation.
/// Includes haptic feedback and proper z-index for FAB.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isProcessingVote = false;
  int _feedRefreshKey = 0;

  late final GetPosts _getPosts;
  late final LikePost _likePost;
  late final FavoriteRepository _favoriteRepository;

  @override
  void initState() {
    super.initState();
    _getPosts = sl<GetPosts>();
    _likePost = sl<LikePost>();
    _favoriteRepository = sl<FavoriteRepository>();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        endDrawer: SideMenuDrawer(
          onNavigate: _handleSideMenuNavigation,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Top bar with search and hamburger menu
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: spacingM,
                  vertical: spacingS,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SearchBarWidget(
                        onSearch: _handleSearch,
                      ),
                    ),
                    const SizedBox(width: spacingS),
                    IconButton(
                      color: primaryColor,
                      icon: const Icon(
                        Icons.menu,
                        size: 28,
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        _openSideMenu();
                      },
                      iconSize: 48, // Proper touch target
                    ),
                  ],
                ),
              ),
              
              // Post feed in center area
              Expanded(
                child: Center(
                  child: BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (prev, curr) => curr is AuthAuthenticated || prev is AuthAuthenticated,
                    builder: (context, authState) {
                      final currentUserUID = authState is AuthAuthenticated
                          ? authState.user.uid
                          : null;
                      return PostFeedWidget(
                        key: ValueKey(_feedRefreshKey),
                        getPosts: _getPosts,
                        onLike: _handleLike,
                        currentUserUID: currentUserUID,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationWidget(
          currentIndex: _currentTabIndex,
          onTabSelected: _handleTabSelected,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            HapticFeedback.mediumImpact();
            _navigateToPostCreation();
          },
          elevation: fabElevation,
          label: const Text('Create'),
          icon: const Icon(Icons.add_outlined),
          heroTag: 'createPostFAB',
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  // Handler methods (to be implemented in next subtask)
  void _handleSearch(String query) {
    debugPrint('Search query: $query');
  }

  void _openSideMenu() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _handleLike(String postId, String userId) async {
    if (_isProcessingVote || userId.isEmpty) return;

    setState(() {
      _isProcessingVote = true;
    });

    final result = await _likePost(postId, userId);

    if (!mounted) return;

    setState(() {
      _isProcessingVote = false;
    });

    result.fold(
      (failure) {
        SnackBarUtils.showError(
          context,
          'Failed to update. Please try again.',
        );
      },
      (updatedPost) async {
        if (updatedPost.likeIDs.contains(userId)) {
          await _favoriteRepository.addToFavorites(postId, userId);
        } else {
          await _favoriteRepository.removeFromFavorites(postId, userId);
        }
        if (!mounted) return;
        setState(() => _feedRefreshKey++);
      },
    );
  }

  void _handleTabSelected(int index) {
    // Don't update state if already on the selected tab
    if (_currentTabIndex == index) {
      return;
    }

    setState(() {
      _currentTabIndex = index;
    });

    // Navigate to different screens based on tab index
    switch (index) {
      case 0:
        // Already on Home screen, do nothing
        break;
      case 1:
        // Navigate to Favorites screen
        Navigator.pushReplacementNamed(context, '/favorites');
        break;
      case 2:
        // Navigate to Account screen
        Navigator.pushReplacementNamed(context, '/account');
        break;
      case 3:
        // Navigate to Messages screen
        Navigator.pushReplacementNamed(context, '/messages');
        break;
    }
  }

  void _navigateToPostCreation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PostCreationScreen(),
      ),
    );
  }

  void _handleSideMenuNavigation(String route) {
    Navigator.pushNamed(context, route);
  }
}
