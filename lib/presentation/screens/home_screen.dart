import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/di/injection.dart';
import '../../core/utils/snackbar_utils.dart';
import '../../application/use_cases/post/get_posts.dart';
import '../../application/use_cases/post/upvote_post.dart';
import '../../application/use_cases/post/downvote_post.dart';
import '../theme/app_theme.dart';
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
  // State variables
  int _currentTabIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isProcessingVote = false;
  
  // Use cases injected via GetIt
  late final GetPosts _getPosts;
  late final UpvotePost _upvotePost;
  late final DownvotePost _downvotePost;

  @override
  void initState() {
    super.initState();
    // Inject use cases
    _getPosts = sl<GetPosts>();
    _upvotePost = sl<UpvotePost>();
    _downvotePost = sl<DownvotePost>();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.backgroundGradient,
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
                  horizontal: AppTheme.spacingM,
                  vertical: AppTheme.spacingS,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SearchBarWidget(
                        onSearch: _handleSearch,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingS),
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
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
                  child: PostFeedWidget(
                    getPosts: _getPosts,
                    onUpvote: _handleUpvote,
                    onDownvote: _handleDownvote,
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
          elevation: AppTheme.fabElevation,
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

  void _handleUpvote(String postId, String userId) async {
    if (_isProcessingVote) return;
    
    setState(() {
      _isProcessingVote = true;
    });

    final result = await _upvotePost(postId, userId);
    
    if (!mounted) return;
    
    setState(() {
      _isProcessingVote = false;
    });

    result.fold(
      (failure) {
        SnackBarUtils.showError(
          context,
          'Failed to upvote post. Please try again.',
        );
      },
      (updatedPost) {
        SnackBarUtils.showSuccess(context, 'Post upvoted!');
        // Trigger a rebuild to refresh the post feed
        setState(() {});
      },
    );
  }

  void _handleDownvote(String postId, String userId) async {
    if (_isProcessingVote) return;
    
    setState(() {
      _isProcessingVote = true;
    });

    final result = await _downvotePost(postId, userId);
    
    if (!mounted) return;
    
    setState(() {
      _isProcessingVote = false;
    });

    result.fold(
      (failure) {
        SnackBarUtils.showError(
          context,
          'Failed to downvote post. Please try again.',
        );
      },
      (updatedPost) {
        SnackBarUtils.showSuccess(context, 'Post downvoted!');
        // Trigger a rebuild to refresh the post feed
        setState(() {});
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
