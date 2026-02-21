import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../application/use_cases/post/get_posts.dart';
import '../../core/error/failures.dart';
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
  final String? currentUserUID;

  const PostFeedWidget({
    super.key,
    required this.getPosts,
    required this.onLike,
    this.currentUserUID,
  });

  @override
  State<PostFeedWidget> createState() => _PostFeedWidgetState();
}

class _PostFeedWidgetState extends State<PostFeedWidget> {
  late Future<dynamic> _postsFuture;

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

              // Posts list with pull-to-refresh
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
                    return PostCard(
                      post: post,
                      onLike: () => widget.onLike(
                        post.id ?? '',
                        widget.currentUserUID ?? '',
                      ),
                      currentUserUID: widget.currentUserUID,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
