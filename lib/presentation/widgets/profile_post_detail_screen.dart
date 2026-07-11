import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/comment/comment_bloc.dart';
import '../theme/colours.dart';
import '../widgets/comments_bottom_sheet.dart';
import '../widgets/post_card.dart';
import '../widgets/profile_posts_grid.dart';
import '../screens/messages_screen.dart';

/// Full-screen post detail opened from a profile/account post grid.
class ProfilePostDetailScreen extends StatelessWidget {
  final String postId;
  final CommentBloc commentBloc;
  final Post? Function(BuildContext context) findPost;
  final void Function(String postId, String userUID) onLike;

  const ProfilePostDetailScreen({
    super.key,
    required this.postId,
    required this.commentBloc,
    required this.findPost,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AuthBloc>().state.user;
    final currentUserUID = currentUser?.uid;
    final currentUserName = currentUser != null
        ? (currentUser.displayName ?? currentUser.email.split('@').first)
        : null;

    final post = findPost(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        elevation: 0,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onSurface),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: backgroundGradient),
        child: SafeArea(
          child: post == null
              ? const Center(child: Text('Post not found'))
              : ListView(
                  children: [
                    PostCard(
                      post: post,
                      currentUserUID: currentUserUID,
                      heroTag: profilePostHeroTag(post.id),
                      onLike: () {
                        if (currentUserUID == null || currentUserUID.isEmpty) {
                          return;
                        }
                        onLike(post.id, currentUserUID);
                      },
                      onComment: () {
                        CommentsBottomSheet.show(
                          context,
                          commentBloc: commentBloc,
                          postId: post.id,
                          currentUserUID: currentUserUID,
                          currentUserName: currentUserName,
                        );
                      },
                      onContactRestaurant: post.hasLinkedRestaurant
                          ? () {
                              openRestaurantConversation(
                                context,
                                restaurantId: post.restaurantId!,
                                restaurantName: post.restaurantName!,
                              );
                            }
                          : null,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
