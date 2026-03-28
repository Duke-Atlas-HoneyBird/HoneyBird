import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';
import '../bloc/feed/feed_bloc.dart';
import '../bloc/feed/feed_event.dart';
import '../bloc/feed/feed_state.dart';
import '../bloc/messages/messages_bloc.dart';
import '../bloc/messages/messages_state.dart';
import '../theme/colours.dart';
import '../theme/text_styles.dart';
import '../theme/spacing.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/post_card.dart';

/// Feed screen displaying curated content feed
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _currentTabIndex = 0;
  bool _hasRequestedLoad = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasRequestedLoad) {
      _hasRequestedLoad = true;
      final uid = context.read<AuthBloc>().state.user?.uid;
      context.read<FeedBloc>().add(FeedEvent.loadFeedPosts(userUID: uid));
    }
  }

  void _handleLike(
    BuildContext context,
    String postId,
    String? currentUserUID,
  ) {
    if (currentUserUID == null) return;
    context.read<FeedBloc>().add(FeedEvent.likePostInFeed(
          postId: postId,
          userUID: currentUserUID,
        ));
  }

  void _handleTabSelected(int index) {
    if (_currentTabIndex == index) {
      return;
    }

    setState(() {
      _currentTabIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).popUntil((route) => route.isFirst);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/favorites');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/account');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/messages');
        break;
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
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: Scaffold(
        appBar: AppBar(
          title: const Text('Feed'),
          centerTitle: false,
          elevation: 0,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.onBackground),
        ),
        body: SafeArea(
          child: BlocConsumer<FeedBloc, FeedState>(
            listenWhen: (prev, curr) => curr.errorMessage != prev.errorMessage,
            listener: (context, state) {
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
            },
            buildWhen: (prev, curr) =>
                prev.posts != curr.posts ||
                prev.isLoading != curr.isLoading ||
                prev.errorMessage != curr.errorMessage,
            builder: (context, state) {
              if (state.errorMessage != null && state.posts.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(spacingL),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: textPrimary,
                        ),
                        const SizedBox(height: spacingM),
                        Text(
                          'Error',
                          style: headlineMedium.copyWith(
                            color: textPrimary,
                          ),
                        ),
                        const SizedBox(height: spacingS),
                        Text(
                          state.errorMessage!,
                          style: bodyLarge.copyWith(
                            color: textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: spacingM),
                        ElevatedButton(
                          onPressed: () {
                            context.read<FeedBloc>().add(
                                FeedEvent.loadFeedPosts(
                                    userUID: context
                                        .read<AuthBloc>()
                                        .state
                                        .user
                                        ?.uid));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: surfaceColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: spacingL,
                              vertical: spacingM,
                            ),
                          ),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (!state.isLoading || state.posts.isNotEmpty) {
                if (state.posts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.rss_feed_outlined,
                          size: 64,
                          color: textSecondary,
                        ),
                        const SizedBox(height: spacingL),
                        Text(
                          'No posts yet',
                          style: headlineMedium.copyWith(
                            color: textPrimary,
                          ),
                        ),
                        const SizedBox(height: spacingM),
                        Text(
                          'Your curated feed will appear here',
                          style: bodyLarge.copyWith(
                            color: textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<FeedBloc>().add(FeedEvent.refreshFeedPosts(
                        userUID: context.read<AuthBloc>().state.user?.uid));
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  color: accentPink,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      final post = state.posts[index];
                      final currentUserUID =
                          context.read<AuthBloc>().state.user?.uid;
                      return PostCard(
                        post: post,
                        onLike: () => _handleLike(
                          context,
                          post.id ?? '',
                          currentUserUID,
                        ),
                        onAuthorTap: (userUID, userName) {
                          Navigator.pushNamed(
                            context,
                            '/profile',
                            arguments: {
                              'userUID': userUID,
                              'userName': userName
                            },
                          );
                        },
                        currentUserUID: currentUserUID,
                      );
                    },
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(textPrimary),
                ),
              );
            },
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
      ),
      ),
    );
  }
}
