import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/entities/post.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';

/// Shared Hero tag for profile/account grid ↔ post detail transitions.
String profilePostHeroTag(String postId) => 'profile-post-$postId';

/// Instagram-style 3-column thumbnail grid of a user's posts.
class ProfilePostsGrid extends StatelessWidget {
  final List<Post> posts;
  final bool isLoading;
  final void Function(Post post) onPostTap;

  const ProfilePostsGrid({
    super.key,
    required this.posts,
    required this.isLoading,
    required this.onPostTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: spacingXl),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(textPrimary),
          ),
        ),
      );
    }

    if (posts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: spacingXl),
        child: Column(
          children: [
            Icon(
              Icons.grid_on_outlined,
              size: 48,
              color: textSecondary.withValues(alpha: 0.6),
            ),
            const SizedBox(height: spacingS),
            Text(
              'No posts yet',
              style: bodyMedium.copyWith(color: textSecondary),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: spacingS),
          child: Row(
            children: [
              const Icon(Icons.grid_on, size: 18, color: textPrimary),
              const SizedBox(width: spacingS),
              Text(
                'Posts',
                style: labelLarge,
              ),
              const Spacer(),
              Text(
                '${posts.length}',
                style: bodyMedium.copyWith(color: textSecondary),
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: posts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemBuilder: (context, index) {
            final post = posts[index];
            return _PostThumbnail(
              post: post,
              onTap: () {
                HapticFeedback.selectionClick();
                onPostTap(post);
              },
            );
          },
        ),
      ],
    );
  }
}

class _PostThumbnail extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;

  const _PostThumbnail({
    required this.post,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = post.imageURL != null;
    final hasVideo = post.videoURL != null;

    return Hero(
      tag: profilePostHeroTag(post.id),
      child: Material(
        color: cardBackground,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (hasImage)
                Image.network(
                  post.imageURL?.toString() ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _textFallback(post),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: cardBackground,
                      alignment: Alignment.center,
                      child: const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                )
              else if (hasVideo)
                Container(
                  color: textSecondary.withValues(alpha: 0.15),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.videocam,
                    size: 32,
                    color: textSecondary,
                  ),
                )
              else
                _textFallback(post),
              if (hasVideo)
                const Positioned(
                  top: 6,
                  right: 6,
                  child: Icon(
                    Icons.play_circle_fill,
                    size: 20,
                    color: Colors.white,
                    shadows: [
                      Shadow(blurRadius: 4, color: Colors.black54),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFallback(Post post) {
    final preview = post.text.trim();
    return Container(
      color: primaryPurple.withValues(alpha: 0.08),
      padding: const EdgeInsets.all(spacingS),
      alignment: Alignment.center,
      child: Text(
        preview.isNotEmpty ? preview : 'Post',
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: bodyMedium.copyWith(
          color: textPrimary,
          fontSize: 11,
          height: 1.2,
        ),
      ),
    );
  }
}
