import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/injection.dart';
import '../../domain/entities/post.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';
import '../theme/border_radius.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/profile/profile_state.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/comment/comment_bloc.dart';
import '../widgets/profile_post_detail_screen.dart';
import '../widgets/profile_posts_grid.dart';

/// Screen for viewing another user's profile.
/// Shows user details, preferences, and Instagram-style post history.
/// Actions: Block/Unblock.
class UserProfileScreen extends StatefulWidget {
  final String targetUserUID;
  final String targetUserName;

  const UserProfileScreen({
    super.key,
    required this.targetUserUID,
    required this.targetUserName,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _hasRequestedLoad = false;
  late final CommentBloc _commentBloc;

  @override
  void initState() {
    super.initState();
    _commentBloc = sl<CommentBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasRequestedLoad) return;
    final viewerUID = context.read<AuthBloc>().state.user?.uid ?? '';
    if (viewerUID.isNotEmpty) {
      _hasRequestedLoad = true;
      context.read<ProfileBloc>().add(ProfileEvent.loadUserProfile(
            targetUserUID: widget.targetUserUID,
            viewerUserUID: viewerUID,
          ));
    }
  }

  void _handleBlock() {
    HapticFeedback.mediumImpact();
    final currentUID = context.read<AuthBloc>().state.user?.uid ?? '';
    if (currentUID.isEmpty) return;

    if (context.read<ProfileBloc>().state.isBlocked) {
      context.read<ProfileBloc>().add(ProfileEvent.unblockUser(
            currentUserUID: currentUID,
            targetUserUID: widget.targetUserUID,
          ));
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Block user?'),
          content: Text(
            'You will no longer see content from ${widget.targetUserName}. '
            'They will not be notified.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<ProfileBloc>().add(ProfileEvent.blockUser(
                      currentUserUID: currentUID,
                      targetUserUID: widget.targetUserUID,
                    ));
              },
              style: TextButton.styleFrom(foregroundColor: errorColor),
              child: const Text('Block'),
            ),
          ],
        ),
      );
    }
  }

  void _openPostDetail(Post post) {
    final profileBloc = context.read<ProfileBloc>();
    final postId = post.id;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: profileBloc,
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return ProfilePostDetailScreen(
                postId: postId,
                commentBloc: _commentBloc,
                findPost: (_) {
                  for (final p in state.posts) {
                    if (p.id == postId) return p;
                  }
                  return null;
                },
                onLike: (likedPostId, userUID) {
                  context.read<ProfileBloc>().add(
                        ProfileEvent.likePostInProfile(
                          postId: likedPostId,
                          userUID: userUID,
                        ),
                      );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.targetUserName.isNotEmpty
            ? widget.targetUserName
            : 'Profile'),
        elevation: 0,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onSurface),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: backgroundGradient),
        child: SafeArea(
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listenWhen: (prev, curr) => curr.errorMessage != prev.errorMessage,
            listener: (context, state) {
              final errorMessage = state.errorMessage;
              if (errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(errorMessage)),
                );
              }
            },
            builder: (context, state) {
              if (state.isLoading && state.user == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(textPrimary),
                  ),
                );
              }

              final errorMessage = state.errorMessage;
              if (errorMessage != null && state.user == null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(spacingL),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: textPrimary),
                        const SizedBox(height: spacingM),
                        Text(
                          errorMessage,
                          style: bodyLarge.copyWith(color: textSecondary),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: spacingM),
                        ElevatedButton(
                          onPressed: () {
                            final viewerUID =
                                context.read<AuthBloc>().state.user?.uid ?? '';
                            context.read<ProfileBloc>().add(
                                  ProfileEvent.loadUserProfile(
                                    targetUserUID: widget.targetUserUID,
                                    viewerUserUID: viewerUID,
                                  ),
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentPink,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final user = state.user;
              final prefs = state.preferences;

              if (user == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final showProfile = prefs?.showProfileToOthers ?? true;
              final showBio = prefs?.showBioToOthers ?? true;
              final showEmail = prefs?.showEmailToOthers ?? false;
              final showPreferences = prefs?.showPreferencesToOthers ?? true;

              final currentUID = context.read<AuthBloc>().state.user?.uid ?? '';
              final isOwnProfile = currentUID == widget.targetUserUID;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(spacingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(spacingM),
                        child: Column(
                          children: [
                            if (showProfile) ...[
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(cardBorderRadius),
                                child: Container(
                                  width: 96,
                                  height: 96,
                                  color: primaryPurple,
                                  alignment: Alignment.center,
                                  child: Text(
                                    user.userName.isNotEmpty
                                        ? user.userName[0].toUpperCase()
                                        : '?',
                                    style: const TextStyle(
                                      fontSize: 40,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: spacingM),
                              Text(
                                user.userName,
                                style: headlineMedium,
                                textAlign: TextAlign.center,
                              ),
                              if (showEmail && user.userEmail.isNotEmpty) ...[
                                const SizedBox(height: spacingXs),
                                Text(
                                  user.userEmail,
                                  style:
                                      bodyMedium.copyWith(color: textSecondary),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ] else ...[
                              const Icon(Icons.person_outline, size: 64),
                              const SizedBox(height: spacingS),
                              Text(
                                'This user has limited their profile visibility',
                                style:
                                    bodyMedium.copyWith(color: textSecondary),
                                textAlign: TextAlign.center,
                              ),
                            ],
                            if (showBio && user.userBio.isNotEmpty) ...[
                              const SizedBox(height: spacingM),
                              Text(
                                'Bio',
                                style: labelLarge,
                              ),
                              const SizedBox(height: spacingXs),
                              Text(user.userBio, style: bodyLarge),
                              if (user.userBioLink.isNotEmpty) ...[
                                const SizedBox(height: spacingS),
                                Text(
                                  user.userBioLink,
                                  style: bodyMedium.copyWith(
                                    color: primaryPurple,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ],
                          ],
                        ),
                      ),
                    ),
                    if (showPreferences && prefs != null) ...[
                      const SizedBox(height: spacingM),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(spacingM),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Preferences',
                                style: headlineMedium,
                              ),
                              const SizedBox(height: spacingM),
                              Wrap(
                                spacing: spacingS,
                                runSpacing: spacingS,
                                children: [
                                  if (prefs.vegetarian) _chip('Vegetarian'),
                                  if (prefs.vegan) _chip('Vegan'),
                                  if (prefs.halaal) _chip('Halaal'),
                                  if (prefs.pork) _chip('No Pork'),
                                  if (prefs.lactose) _chip('Lactose-free'),
                                  if (prefs.outdoor) _chip('Outdoor'),
                                  if (prefs.wineTasting) _chip('Wine Tasting'),
                                  if (prefs.wineFarms) _chip('Wine Farms'),
                                  if (prefs.african) _chip('African'),
                                  if (prefs.italian) _chip('Italian'),
                                  if (prefs.greek) _chip('Greek'),
                                  if (prefs.chinese) _chip('Chinese'),
                                  if (prefs.thai) _chip('Thai'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: spacingL),
                    ProfilePostsGrid(
                      posts: state.posts,
                      isLoading: state.isLoadingPosts,
                      onPostTap: _openPostDetail,
                    ),
                    if (!isOwnProfile) ...[
                      const SizedBox(height: spacingL),
                      OutlinedButton.icon(
                        onPressed: _handleBlock,
                        icon: Icon(
                          state.isBlocked
                              ? Icons.block
                              : Icons.block_outlined,
                        ),
                        label: Text(state.isBlocked ? 'Unblock' : 'Block'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: state.isBlocked
                              ? accentPink
                              : textSecondary,
                          side: BorderSide(
                            color: state.isBlocked
                                ? accentPink
                                : textSecondary.withValues(alpha: 0.5),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: spacingM),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(buttonBorderRadius),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _chip(String label) {
    return Chip(
      label: Text(label, style: Theme.of(context).textTheme.labelMedium),
      backgroundColor: primaryPurple.withValues(alpha: 0.15),
      side: BorderSide.none,
    );
  }
}
