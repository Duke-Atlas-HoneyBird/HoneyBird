import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../application/use_cases/post/get_posts.dart';
import '../../core/error/failures.dart';
import '../theme/app_theme.dart';
import 'post_card.dart';

/// A widget that displays a scrollable feed of posts
/// 
/// This widget handles loading posts from the backend, displaying them in a list,
/// and managing loading, error, and empty states with retry functionality.
/// Includes pull-to-refresh and smooth scrolling behavior.
class PostFeedWidget extends StatefulWidget {
  final GetPosts getPosts;
  final Function(String postId, String userId) onUpvote;
  final Function(String postId, String userId) onDownvote;

  const PostFeedWidget({
    super.key,
    required this.getPosts,
    required this.onUpvote,
    required this.onDownvote,
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
    final screenHeight = MediaQuery.of(context).size.height;
    final feedHeight = screenHeight * 0.4; // ~40% of screen height

    return SizedBox(
      height: feedHeight,
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
                padding: const EdgeInsets.all(AppTheme.spacingL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppTheme.downvoteRed,
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    const Text(
                      'Oops!',
                      style: AppTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacingS),
                    const Text(
                      'Unable to load posts. Please try again.',
                      style: AppTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    ElevatedButton.icon(
                      onPressed: _retryLoadPosts,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentPink,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingL,
                          vertical: AppTheme.spacingM,
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
                padding: const EdgeInsets.all(AppTheme.spacingL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppTheme.downvoteRed,
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    const Text(
                      'Oops!',
                      style: AppTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacingS),
                    Text(
                      _getErrorMessage(failure),
                      style: AppTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    ElevatedButton.icon(
                      onPressed: _retryLoadPosts,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentPink,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingL,
                          vertical: AppTheme.spacingM,
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
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.spacingL),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: AppTheme.textSecondary,
                        ),
                        SizedBox(height: AppTheme.spacingM),
                        Text(
                          'No posts yet',
                          style: AppTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: AppTheme.spacingS),
                        Text(
                          'Be the first to share something!',
                          style: AppTheme.bodyMedium,
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
                color: AppTheme.accentPink,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return PostCard(
                      post: post,
                      onUpvote: () => widget.onUpvote(post.id ?? '', post.userUID),
                      onDownvote: () => widget.onDownvote(post.id ?? '', post.userUID),
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
