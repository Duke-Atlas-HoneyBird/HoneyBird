import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/injection.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';
import '../bloc/comment/comment_bloc.dart';
import '../bloc/comment_count/comment_count_bloc.dart';
import '../bloc/comment_count/comment_count_event.dart';
import '../bloc/feed/feed_bloc.dart';
import '../bloc/feed/feed_event.dart';
import '../bloc/feed/feed_state.dart';
import '../bloc/messages/messages_bloc.dart';
import '../bloc/messages/messages_event.dart';
import '../bloc/messages/messages_state.dart';
import '../theme/colours.dart';
import '../theme/constants.dart';
import '../theme/spacing.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/post_feed_widget.dart';
import '../widgets/comments_bottom_sheet.dart';
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
  bool _hasRequestedLoad = false;
  bool _hasRequestedUnreadCount = false;

  late final CommentBloc _commentBloc;
  late final CommentCountBloc _commentCountBloc;

  @override
  void initState() {
    super.initState();
    _commentBloc = sl<CommentBloc>();
    _commentCountBloc = sl<CommentCountBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasRequestedLoad) {
      _hasRequestedLoad = true;
      final uid = context.read<AuthBloc>().state.user?.uid;
      context.read<FeedBloc>().add(FeedEvent.loadFeedPosts(userUID: uid));
    }
    if (!_hasRequestedUnreadCount) {
      _hasRequestedUnreadCount = true;
      final uid = context.read<AuthBloc>().state.user?.uid ?? '';
      if (uid.isNotEmpty) {
        context.read<MessagesBloc>().add(MessagesEvent.loadUnreadCount(uid));
      }
    }
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
              
              // Post feed in center area (CommentCountBloc so counts update and UI re-renders)
              Expanded(
                child: Center(
                  child: BlocProvider.value(
                    value: _commentCountBloc,
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {},
                      buildWhen: (prev, curr) => prev?.user != curr.user,
                      builder: (context, authState) {
                        final currentUserUID = authState.user?.uid;
                        final currentUserName = authState.user != null
                            ? (authState.user!.displayName ??
                                authState.user!.email.split('@').first)
                            : null;
                        return BlocConsumer<FeedBloc, FeedState>(
                          listenWhen: (prev, curr) =>
                              prev?.errorMessage != curr.errorMessage,
                          listener: (context, state) {
                            if (state.errorMessage != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.errorMessage!)),
                              );
                            }
                          },
                          buildWhen: (prev, curr) =>
                              prev?.posts != curr.posts ||
                              prev?.isLoading != curr.isLoading,
                          builder: (context, feedState) {
                            return PostFeedWidget(
                              posts: feedState.posts,
                              isLoading: feedState.isLoading,
                              onRefresh: () {
                                final uid = context.read<AuthBloc>().state.user?.uid;
                                context.read<FeedBloc>().add(FeedEvent.refreshFeedPosts(userUID: uid));
                              },
                              onRetry: () {
                                final uid = context.read<AuthBloc>().state.user?.uid;
                                context.read<FeedBloc>().add(FeedEvent.loadFeedPosts(userUID: uid));
                              },
                              onLike: (postId, userId) {
                                context.read<FeedBloc>().add(
                                      FeedEvent.likePostInFeed(
                                        postId: postId,
                                        userUID: userId,
                                      ),
                                    );
                              },
                              onCommentTap: (postId) => _openComments(
                                context,
                                postId: postId,
                                currentUserUID: currentUserUID,
                                currentUserName: currentUserName,
                              ),
                              onAuthorTap: (userUID, userName) {
                                Navigator.pushNamed(
                                  context,
                                  '/profile',
                                  arguments: {
                                    'userUID': userUID,
                                    'userName': userName,
                                  },
                                );
                              },
                              currentUserUID: currentUserUID,
                              errorMessage: feedState.errorMessage,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<MessagesBloc, MessagesState>(
          buildWhen: (prev, curr) => prev?.unreadCount != curr.unreadCount,
          builder: (context, messagesState) => BottomNavigationWidget(
            currentIndex: _currentTabIndex,
            onTabSelected: _handleTabSelected,
            unreadMessageCount: messagesState.unreadCount,
          ),
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

  void _openComments(
    BuildContext context, {
    required String postId,
    String? currentUserUID,
    String? currentUserName,
  }) {
    CommentsBottomSheet.show(
      context,
      commentBloc: _commentBloc,
      postId: postId,
      currentUserUID: currentUserUID,
      currentUserName: currentUserName,
      onCommentCountChanged: (count) {
        _commentCountBloc.add(
          CommentCountEvent.countUpdated(postId: postId, count: count),
        );
      },
    );
  }
}
