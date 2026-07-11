import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/post.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/border_radius.dart';
import '../theme/text_styles.dart';

/// Aspect ratio for feed images — mobile-first (portrait-friendly, like phone photos).
const double _feedImageAspectRatio = 4 / 5;

/// A card widget that displays a post with star (like) and comment functionality.
/// Includes haptic feedback and proper touch targets (48dp minimum).
/// Image frame is optimized for mobile viewing.
class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  /// Called when user taps comment — opens comments sheet when provided.
  final VoidCallback? onComment;
  /// Called when user taps author name/avatar — opens their profile.
  final void Function(String userUID, String userName)? onAuthorTap;
  /// Called when user taps contact restaurant on a linked post.
  final VoidCallback? onContactRestaurant;
  /// Current user's UID — if in [post.likeIDs], star is filled.
  final String? currentUserUID;
  /// Number of comments to show on the comment button (defaults to 0).
  final int commentCount;
  /// When set, wraps the primary media in a [Hero] for shared-element transitions.
  final String? heroTag;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    this.onComment,
    this.onAuthorTap,
    this.onContactRestaurant,
    this.currentUserUID,
    this.commentCount = 0,
    this.heroTag,
  });

  Widget _wrapHero(bool enabled, Widget child) {
    final tag = heroTag;
    if (!enabled || tag == null) return child;
    return Hero(
      tag: tag,
      child: Material(
        type: MaterialType.transparency,
        child: child,
      ),
    );
  }

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
    // Match grid priority: image > video > text (only one Hero per tag).
    final heroOnImage = heroTag != null && post.imageURL != null;
    final heroOnVideo =
        heroTag != null && post.imageURL == null && post.videoURL != null;
    final heroOnText = heroTag != null &&
        post.imageURL == null &&
        post.videoURL == null;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: spacingM,
        vertical: spacingS,
      ),
      child: Padding(
        padding: const EdgeInsets.all(spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info and date — tappable to view profile
            InkWell(
              onTap: onAuthorTap != null && post.userUID.isNotEmpty
                  ? () {
                      HapticFeedback.lightImpact();
                      onAuthorTap?.call(post.userUID, post.userName);
                    }
                  : null,
              borderRadius: BorderRadius.circular(buttonBorderRadius),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                    child: Container(
                      width: 56,
                      height: 56,
                      color: primaryPurple,
                      alignment: Alignment.center,
                      child: Text(
                        post.userName.isNotEmpty ? post.userName[0].toUpperCase() : '?',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: spacingS),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.userName,
                          style: labelLarge,
                        ),
                        Text(
                          _formatDate(post.publishedDate),
                          style: bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: spacingM),

            // Caption (optional) — skipped when text-only Hero owns the text
            if (post.text.isNotEmpty && !heroOnText)
              Text(
                post.text,
                style: bodyLarge,
              ),

            // Video (if available) — show placeholder; video_player can be added later
            if (post.videoURL != null) ...[
              const SizedBox(height: spacingM),
              _wrapHero(
                heroOnVideo,
                ClipRRect(
                  borderRadius: BorderRadius.circular(buttonBorderRadius),
                  child: AspectRatio(
                    aspectRatio: _feedImageAspectRatio,
                    child: Container(
                      color: textSecondary.withOpacity(0.15),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.videocam,
                              size: 48,
                              color: textSecondary,
                            ),
                            const SizedBox(height: spacingS),
                            Text(
                              'Video',
                              style: bodyMedium.copyWith(color: textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            // Post image (if available) — mobile-first aspect ratio
            if (post.imageURL != null) ...[
              const SizedBox(height: spacingM),
              _wrapHero(
                heroOnImage,
                ClipRRect(
                  borderRadius: BorderRadius.circular(buttonBorderRadius),
                  child: AspectRatio(
                    aspectRatio: _feedImageAspectRatio,
                    child: Image.network(
                      post.imageURL?.toString() ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: textSecondary.withOpacity(0.1),
                          child: const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 48,
                              color: textSecondary,
                            ),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        final expectedTotalBytes =
                            loadingProgress.expectedTotalBytes;
                        return Container(
                          color: textSecondary.withOpacity(0.1),
                          child: Center(
                            child: CircularProgressIndicator(
                              value: expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      expectedTotalBytes
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
            // Text-only posts: hero the caption block so grid transitions still work
            if (heroOnText) ...[
              const SizedBox(height: spacingM),
              _wrapHero(
                true,
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(spacingM),
                  decoration: BoxDecoration(
                    color: primaryPurple.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(buttonBorderRadius),
                  ),
                  child: Text(
                    post.text.trim().isNotEmpty ? post.text : 'Post',
                    style: bodyLarge,
                  ),
                ),
              ),
            ],
            if (post.hasLinkedRestaurant) ...[
              const SizedBox(height: spacingM),
              OutlinedButton.icon(
                onPressed: onContactRestaurant == null
                    ? null
                    : () {
                        HapticFeedback.lightImpact();
                        onContactRestaurant?.call();
                      },
                icon: const Icon(Icons.storefront_outlined, size: 18),
                label: Text('Contact ${post.restaurantName}'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryPurple,
                  side: BorderSide(color: primaryPurple.withValues(alpha: 0.5)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: spacingM,
                    vertical: spacingS,
                  ),
                ),
              ),
            ],
            const SizedBox(height: spacingM),
            
            // Star (like) and comment actions
            Row(
              children: [
                InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onLike();
                  },
                  borderRadius: BorderRadius.circular(buttonBorderRadius),
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 48.0,
                      minWidth: 48.0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: spacingM,
                      vertical: spacingM,
                    ),
                    decoration: BoxDecoration(
                      color: starGold.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(buttonBorderRadius),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          (currentUserUID != null && post.likeIDs.contains(currentUserUID))
                              ? Icons.star
                              : Icons.star_border,
                          color: starGold,
                          size: 22,
                        ),
                        const SizedBox(width: spacingXs),
                        Text(
                          post.likeIDs.length.toString(),
                          style: labelLarge.copyWith(
                            color: starGold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (onComment != null) ...[
                  const SizedBox(width: spacingS),
                  InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onComment?.call();
                    },
                    borderRadius: BorderRadius.circular(buttonBorderRadius),
                    child: Container(
                      constraints: const BoxConstraints(
                        minHeight: 48.0,
                        minWidth: 48.0,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: spacingM,
                        vertical: spacingM,
                      ),
                      decoration: BoxDecoration(
                        color: textSecondary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(buttonBorderRadius),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            color: textSecondary,
                            size: 22,
                          ),
                          const SizedBox(width: spacingXs),
                          Text(
                            commentCount == 0
                                ? 'Comment'
                                : commentCount.toString(),
                            style: labelLarge.copyWith(
                              color: textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
