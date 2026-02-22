import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/use_cases/post/get_posts.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/post.dart';
import '../state/comment_count/comment_count_bloc.dart';
import '../state/comment_count/comment_count_event.dart';
import '../state/comment_count/comment_count_state.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';
import 'post_card.dart';

/// A widget that displays a scrollable feed of posts
///
/// This widget handles loading posts from the backend, displaying them in a list,
/// and managing loading, error, and empty states with retry functionality.
/// Includes pull-to-refresh and smooth scrolling behavior.
class PostFeedWidget extends StatefulWidget {
  final GetPosts getPosts;
  final Function(String postId, String userId) onLike;
  /// Called when user taps comment on a post. If null, comment button is hidden.
  final void Function(String postId)? onCommentTap;
  final String? currentUserUID;

  const PostFeedWidget({
    super.key,
    required this.getPosts,
    required this.onLike,
    this.onCommentTap,
    this.currentUserUID,
  });

  @override
  State<PostFeedWidget> createState() => _PostFeedWidgetState();
}

class _PostFeedWidgetState extends State<PostFeedWidget> {
  late Future<Either<Failure, List<Post>>> _postsFuture;
  List<String>? _lastRequestedPostIds;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  /// Load posts from the backend
  void _loadPosts() {
    setState(() {
      _postsFuture = widget.getPosts();
    });
  }

  /// Retry loading posts after an error
  void _retryLoadPosts() {
    _loadPosts();
  }

  /// Handle pull-to-refresh
  Future<void> _handleRefresh() async {
    HapticFeedback.lightImpact();
    _lastRequestedPostIds = null;
    _loadPosts();
    // Wait for the future to complete
    await _postsFuture;
  }

  String _getErrorMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'No internet connection. Please check your network.';
    } else if (failure is ServerFailure) {
      return 'Unable to load posts. Please try again later.';
    } else {
      return 'Something went wrong. Please try again.';
    }
  }

  static bool _setEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    final setA = Set.from(a);
    final setB = Set.from(b);
    return setA.length == setB.length && setA.difference(setB).isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder(
        future: _postsFuture,
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error state
          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(spacingL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: accentPink,
                    ),
                    const SizedBox(height: spacingM),
                    Text(
                      'Oops!',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: spacingS),
                    Text(
                      'Unable to load posts. Please try again.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: spacingM),
                    ElevatedButton.icon(
                      onPressed: _retryLoadPosts,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentPink,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: spacingL,
                          vertical: spacingM,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final result = snapshot.data!;

          // Handle Either result from use case
          return result.fold(
            // Error case
            (failure) => Center(
              child: Padding(
                padding: const EdgeInsets.all(spacingL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: accentPink,
                    ),
                    const SizedBox(height: spacingM),
                     Text(
                      'Oops!',
                    style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: spacingS),
                    Text(
                      _getErrorMessage(failure),
                      style: bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: spacingM),
                    ElevatedButton.icon(
                      onPressed: _retryLoadPosts,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentPink,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: spacingL,
                          vertical: spacingM,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Success case
            (posts) {
              // Empty state
              if (posts.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(spacingL),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: textSecondary,
                        ),
                        SizedBox(height: spacingM),
                        Text(
                          'No posts yet',
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: spacingS),
                        Text(
                          'Be the first to share something!',
                          style: bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Request comment counts once for this set of posts (triggers re-build when counts arrive)
              final postIds = posts
                  .map((p) => p.id ?? '')
                  .where((id) => id.isNotEmpty)
                  .toList();
              final needCounts = postIds.isNotEmpty &&
                  (_lastRequestedPostIds == null ||
                      !_setEquals(_lastRequestedPostIds!, postIds));
              if (needCounts) {
                _lastRequestedPostIds = List.from(postIds);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;
                  context.read<CommentCountBloc>().add(
                    CommentCountEvent.loadCountsForPosts(postIds: postIds),
                  );
                });
              }

              // Rebuild when comment counts change so UI shows updated numbers
              return BlocBuilder<CommentCountBloc, CommentCountState>(
                builder: (context, countState) {
                  return RefreshIndicator(
                    onRefresh: _handleRefresh,
                    color: accentPink,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        final postId = post.id ?? '';
                        final commentCount = postId.isEmpty
                            ? 0
                            : (countState.counts[postId] ?? 0);
                        return PostCard(
                          post: post,
                          onLike: () => widget.onLike(
                            postId,
                            widget.currentUserUID ?? '',
                          ),
                          onComment: widget.onCommentTap != null
                              ? () => widget.onCommentTap!(postId)
                              : null,
                          currentUserUID: widget.currentUserUID,
                          commentCount: commentCount,
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
