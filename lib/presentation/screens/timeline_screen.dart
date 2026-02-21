import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honey_bird/application/use_cases/post/like_post.dart';
import 'package:honey_bird/core/di/injection.dart';
import 'package:honey_bird/domain/repositories/favorite_repository.dart';
import 'package:honey_bird/domain/repositories/post_repository.dart';
import 'package:honey_bird/presentation/state/auth/auth_bloc.dart';
import 'package:honey_bird/presentation/state/auth/auth_state.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../state/timeline/timeline_bloc.dart';
import '../state/timeline/timeline_event.dart';
import '../state/timeline/timeline_state.dart';
import '../widgets/post_card.dart';

/// Timeline screen displaying chronological content
class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentTabIndex = 0;
  bool _hasRequestedLoad = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasRequestedLoad) {
      _hasRequestedLoad = true;
      context.read<TimelineBloc>().add(const LoadTimelinePosts());
    }
  }

  @override
  void deactivate() {
    _hasRequestedLoad = false;
    super.deactivate();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<TimelineBloc>().add(const LoadMoreTimelinePosts());
    }
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

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Timeline'),
            elevation: 0,
            iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onBackground),
          ),
          body: BlocBuilder<TimelineBloc, TimelineState>(
            builder: (context, state) {
              if (state is TimelineLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onBackground),
                  ),
                );
              }

              if (state is TimelineError) {
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
                          state.message,
                          style: bodyLarge.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: spacingM),
                        ElevatedButton(
                          onPressed: () {
                            context.read<TimelineBloc>().add(const LoadTimelinePosts());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentPink,
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

              if (state is TimelineLoaded) {
                if (state.posts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timeline_outlined,
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
                          'Your timeline will appear here',
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
                     context.read<TimelineBloc>().add(const RefreshTimelinePosts());
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  color: accentPink,
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.posts.length + (state.isLoadingMore ? 1 : 0) + (state.hasMore ? 0 : 1),
                    itemBuilder: (context, index) {
                      if (index == state.posts.length) {
                        if (state.isLoadingMore) {
                          return const Padding(
                            padding: EdgeInsets.all(spacingM),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (!state.hasMore) {
                          return Padding(
                            padding: const EdgeInsets.all(spacingM),
                            child: Center(
                                child: Text(
                                  'No more posts to load',
                                  style: bodyMedium.copyWith(
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                            ),
                          );
                        }
                      }

                      final post = state.posts[index];
                      final currentUserUID = context.read<AuthBloc>().state is AuthAuthenticated
                          ? (context.read<AuthBloc>().state as AuthAuthenticated).user.uid
                          : null;
                      return PostCard(
                        post: post,
                        onLike: () => _handleLike(context, post.id, currentUserUID, post.likeIDs.contains(currentUserUID) ?? false),
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
          bottomNavigationBar: BottomNavigationWidget(
            currentIndex: _currentTabIndex,
            onTabSelected: _handleTabSelected,
          ),
        ),
    );
  }

  Future<void> _handleLike(
    BuildContext context,
    String postId,
    String? currentUserUID,
    bool isCurrentlyLiked,
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
        context.read<TimelineBloc>().add(UpdateTimelinePost(updatedPost));
      },
    );
  
  }
}
