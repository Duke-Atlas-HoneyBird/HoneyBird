import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post.dart';
import '../bloc/comment_count/comment_count_bloc.dart';
import '../bloc/comment_count/comment_count_event.dart';
import '../bloc/comment_count/comment_count_state.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';
import 'post_card.dart';

/// A widget that displays a scrollable feed of posts
///
/// Receives posts from parent (e.g. Bloc state). Handles loading, error,
/// and empty states. Includes pull-to-refresh.
class PostFeedWidget extends StatefulWidget {
  final List<Post> posts;
  final bool isLoading;
  final VoidCallback onRefresh;
  final VoidCallback onRetry;
  final void Function(String postId, String userId) onLike;
  /// Called when user taps comment on a post. If null, comment button is hidden.
  final void Function(String postId)? onCommentTap;
  /// Called when user taps author name/avatar to view their profile.
  final void Function(String userUID, String userName)? onAuthorTap;
  /// Called when user taps contact restaurant on a linked post.
  final void Function(Post post)? onContactRestaurant;
  final String? currentUserUID;
  final String? errorMessage;

  const PostFeedWidget({
    super.key,
    required this.posts,
    required this.isLoading,
    required this.onRefresh,
    required this.onRetry,
    required this.onLike,
    this.onCommentTap,
    this.onAuthorTap,
    this.onContactRestaurant,
    this.currentUserUID,
    this.errorMessage,
  });

  @override
  State<PostFeedWidget> createState() => _PostFeedWidgetState();
}

class _PostFeedWidgetState extends State<PostFeedWidget> {
  List<String>? _lastRequestedPostIds;

  static bool _setEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    final setA = Set.from(a);
    final setB = Set.from(b);
    return setA.length == setB.length && setA.difference(setB).isEmpty;
  }

  Future<void> _handleRefresh() async {
    HapticFeedback.lightImpact();
    _lastRequestedPostIds = null;
    widget.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    // Loading state (initial load only)
    if (widget.isLoading && widget.posts.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Error state (when we have an error and no posts)
    if (widget.errorMessage != null && widget.posts.isEmpty) {
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
                widget.errorMessage ?? 'Unable to load posts. Please try again.',
                style: bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: spacingM),
              ElevatedButton.icon(
                onPressed: widget.onRetry,
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

    return _buildPostsList(widget.posts);
  }

  Widget _buildPostsList(List<Post> posts) {
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
                onAuthorTap: widget.onAuthorTap,
                onContactRestaurant: post.hasLinkedRestaurant &&
                        widget.onContactRestaurant != null
                    ? () => widget.onContactRestaurant!(post)
                    : null,
                currentUserUID: widget.currentUserUID,
                commentCount: commentCount,
              );
            },
          ),
        );
      },
    );
  }
}
