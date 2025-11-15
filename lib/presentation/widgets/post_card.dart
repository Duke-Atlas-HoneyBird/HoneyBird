import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/post.dart';
import '../theme/app_theme.dart';

/// A card widget that displays a post with voting functionality
/// Includes haptic feedback and proper touch targets (48dp minimum)
class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onUpvote;
  final VoidCallback onDownvote;

  const PostCard({
    super.key,
    required this.post,
    required this.onUpvote,
    required this.onDownvote,
  });

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return DateFormat('MMM d, yyyy').format(date);
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: AppTheme.spacingS,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info and date
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppTheme.primaryPurple,
                  child: Text(
                    post.userName.isNotEmpty ? post.userName[0].toUpperCase() : '?',
                    style: AppTheme.labelLarge.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingS),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.userName,
                        style: AppTheme.labelLarge,
                      ),
                      Text(
                        _formatDate(post.publishedDate),
                        style: AppTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingM),
            
            // Post text
            Text(
              post.text,
              style: AppTheme.bodyLarge,
            ),
            
            // Post image (if available)
            if (post.imageURL != null) ...[
              const SizedBox(height: AppTheme.spacingM),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                child: Image.network(
                  post.imageURL!.toString(),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: AppTheme.textSecondary.withValues(alpha: 0.1),
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 48,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 200,
                      color: AppTheme.textSecondary.withValues(alpha: 0.1),
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            
            const SizedBox(height: AppTheme.spacingM),
            
            // Voting buttons with haptic feedback and proper touch targets (48dp minimum)
            Row(
              children: [
                // Upvote button
                InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onUpvote();
                  },
                  borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 48.0, // Minimum touch target
                      minWidth: 48.0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingM,
                      vertical: AppTheme.spacingM,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.upvoteGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.arrow_upward,
                          color: AppTheme.upvoteGreen,
                          size: 20,
                        ),
                        const SizedBox(width: AppTheme.spacingXs),
                        Text(
                          post.upvoteIDs.length.toString(),
                          style: AppTheme.labelLarge.copyWith(
                            color: AppTheme.upvoteGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingM),
                
                // Downvote button
                InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onDownvote();
                  },
                  borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 48.0, // Minimum touch target
                      minWidth: 48.0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingM,
                      vertical: AppTheme.spacingM,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.downvoteRed.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.arrow_downward,
                          color: AppTheme.downvoteRed,
                          size: 20,
                        ),
                        const SizedBox(width: AppTheme.spacingXs),
                        Text(
                          post.downvoteIDs.length.toString(),
                          style: AppTheme.labelLarge.copyWith(
                            color: AppTheme.downvoteRed,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
