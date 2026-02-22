import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/injection.dart';
import '../../application/use_cases/post/like_post.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../state/auth/auth_bloc.dart';
import '../state/auth/auth_state.dart';
import '../state/feed/feed_bloc.dart';
import '../state/feed/feed_event.dart';
import '../state/feed/feed_state.dart';
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
      context.read<FeedBloc>().add(const FeedEvent.loadFeedPosts());
    }
  }

  Future<void> _handleLike(
    BuildContext context,
    String postId,
    String? currentUserUID,
  ) async {
    if (currentUserUID == null) return;
    final result = await sl<LikePost>().call(postId, currentUserUID);
    result.fold(
      (_) {},
      (updatedPost) async {
        final repo = sl<FavoriteRepository>();
        if (updatedPost.likeIDs.contains(currentUserUID)) {
          await repo.addToFavorites(postId, currentUserUID);
        } else {
          await repo.removeFromFavorites(postId, currentUserUID);
        }
        if (!context.mounted) return;
        context.read<FeedBloc>().add(FeedEvent.addOrUpdatePostToFeed(updatedPost));
      },
    );
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
        Navigator.pushReplacementNamed(context, '/home');
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
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Feed'),
            elevation: 0,
            iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onBackground),
          ),
          body: SafeArea(
            child: BlocConsumer<FeedBloc, FeedState>(
            listenWhen: (prev, curr) => curr.errorMessage != prev?.errorMessage,
            listener: (context, state) {
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
            },
            buildWhen: (prev, curr) =>
                prev?.posts != curr.posts ||
                prev?.isLoading != curr.isLoading ||
                prev?.errorMessage != curr.errorMessage,
            builder: (context, state) {
              if (state.errorMessage != null && state.posts.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(spacingL),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.white,
                        ),
                        const SizedBox(height: spacingM),
                        Text(
                          'Error',
                          style: headlineMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: spacingS),
                        Text(
                          state.errorMessage!,
                          style: bodyLarge.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: spacingM),
                        ElevatedButton(
                          onPressed: () {
                            context.read<FeedBloc>().add(const FeedEvent.loadFeedPosts());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
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
                          color: Colors.white.withOpacity(0.7),
                        ),
                        const SizedBox(height: spacingL),
                        Text(
                          'No posts yet',
                          style: headlineMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: spacingM),
                        Text(
                          'Your curated feed will appear here',
                          style: bodyLarge.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<FeedBloc>().add(const FeedEvent.refreshFeedPosts());
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  color: accentPink,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      final post = state.posts[index];
                      final currentUserUID = context.read<AuthBloc>().state.user?.uid;
                      return PostCard(
                        post: post,
                        onLike: () => _handleLike(
                          context,
                          post.id ?? '',
                          currentUserUID,
                        ),
                        currentUserUID: currentUserUID,
                      );
                    },
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            },
          ),
          ),
          bottomNavigationBar: BottomNavigationWidget(
            currentIndex: _currentTabIndex,
            onTabSelected: _handleTabSelected,
          ),
        ),
    );
  }
}
