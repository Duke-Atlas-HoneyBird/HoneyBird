import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
import '../router/app_router.dart';
import '../theme/colours.dart';
import '../theme/constants.dart';
import '../widgets/post_feed_widget.dart';
import '../widgets/comments_bottom_sheet.dart';
import '../widgets/bottom_navigation_widget.dart';
import 'messages_screen.dart';

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
  bool _hasRequestedLoad = false;
  bool _hasRequestedUnreadCount = false;

  static const _menuItems = <_HomeMenuAction, String>{
    _HomeMenuAction.account: 'Account',
    _HomeMenuAction.manage: 'Manage',
    _HomeMenuAction.timeline: 'Timeline',
    _HomeMenuAction.feed: 'Feed',
  };

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
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          // For HomeScreen (root), we can show an exit confirmation if needed, 
          // but for now let's just allow default behavior if they are at the root.
          // However, here we might want to ensure it doesn't pop accidentally.
          SystemNavigator.pop();
        },
        child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Honey Bird'),
          centerTitle: false,
          elevation: 0,
          actions: [
            PopupMenuButton<_HomeMenuAction>(
              icon: const Icon(Icons.more_vert),
              onSelected: _onMenuItemSelected,
              itemBuilder: (context) {
                return _menuItems.entries
                    .map(
                      (entry) => PopupMenuItem<_HomeMenuAction>(
                        value: entry.key,
                        child: Text(entry.value),
                      ),
                    )
                    .toList();
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Post feed in center area (CommentCountBloc so counts update and UI re-renders)
              Expanded(
                child: Center(
                  child: BlocProvider.value(
                    value: _commentCountBloc,
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {},
                      buildWhen: (prev, curr) => prev.user != curr.user,
                      builder: (context, authState) {
                        final currentUserUID = authState.user?.uid;
                        final currentUserName = authState.user != null
                            ? (authState.user!.displayName ??
                                authState.user!.email.split('@').first)
                            : null;
                        return BlocConsumer<FeedBloc, FeedState>(
                          listenWhen: (prev, curr) =>
                              prev.errorMessage != curr.errorMessage,
                          listener: (context, state) {
                            if (state.errorMessage != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.errorMessage!)),
                              );
                            }
                          },
                          buildWhen: (prev, curr) =>
                              prev.posts != curr.posts ||
                              prev.isLoading != curr.isLoading,
                          builder: (context, feedState) {
                            return PostFeedWidget(
                              posts: feedState.posts,
                              isLoading: feedState.isLoading,
                              onRefresh: () {
                                final uid =
                                    context.read<AuthBloc>().state.user?.uid;
                                context.read<FeedBloc>().add(
                                    FeedEvent.refreshFeedPosts(userUID: uid));
                              },
                              onRetry: () {
                                final uid =
                                    context.read<AuthBloc>().state.user?.uid;
                                context
                                    .read<FeedBloc>()
                                    .add(FeedEvent.loadFeedPosts(userUID: uid));
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
                                context.push(
                                  AppRoutes.profileLocation(userUID, userName),
                                );
                              },
                              onContactRestaurant: (post) {
                                openRestaurantConversation(
                                  context,
                                  restaurantId: post.restaurantId!,
                                  restaurantName: post.restaurantName!,
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
          buildWhen: (prev, curr) => prev.unreadCount != curr.unreadCount,
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
      ),
    );
  }

  // Handler methods (to be implemented in next subtask)
  void _handleSearch(String query) {
    debugPrint('Search query: $query');
  }

  void _handleTabSelected(int index) {
    if (_currentTabIndex == index) {
      return;
    }

    setState(() {
      _currentTabIndex = index;
    });

    AppRoutes.goTab(context, index);

    // Home tab stays selected when we remain on /home; other tabs navigate away.
    if (index != 0 && mounted) {
      setState(() {
        _currentTabIndex = 0;
      });
    }
  }

  void _navigateToPostCreation() {
    context.push(AppRoutes.createPost);
  }

  void _onMenuItemSelected(_HomeMenuAction action) {
    HapticFeedback.selectionClick();
    switch (action) {
      case _HomeMenuAction.account:
        context.push(AppRoutes.account);
      case _HomeMenuAction.manage:
        context.push(AppRoutes.manage);
      case _HomeMenuAction.timeline:
        context.push(AppRoutes.timeline);
      case _HomeMenuAction.feed:
        context.push(AppRoutes.feed);
    }
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

enum _HomeMenuAction { account, manage, timeline, feed }
