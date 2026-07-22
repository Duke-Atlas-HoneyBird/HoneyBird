import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/border_radius.dart';
import '../theme/colours.dart';
import '../theme/text_styles.dart';
import '../theme/spacing.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/profile_post_detail_screen.dart';
import '../widgets/profile_posts_grid.dart';
import '../bloc/account/account_bloc.dart';
import '../bloc/account/account_event.dart';
import '../bloc/account/account_state.dart';
import '../bloc/messages/messages_bloc.dart';
import '../bloc/messages/messages_event.dart';
import '../bloc/messages/messages_state.dart';
import '../bloc/comment/comment_bloc.dart';

import '../../core/di/injection.dart';
import '../../domain/entities/post.dart';
import '../bloc/auth/auth_bloc.dart';

/// Account screen for managing user account settings
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _currentTabIndex = 2;
  bool _hasRequestedLoad = false;
  bool _hasRequestedUnreadCount = false;
  late final CommentBloc _commentBloc;

  @override
  void initState() {
    super.initState();
    _commentBloc = sl<CommentBloc>();
  }

  void _handleTabSelected(int index) {
    if (_currentTabIndex == index) {
      return;
    }

    setState(() {
      _currentTabIndex = index;
    });

    AppRoutes.goTab(context, index);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasRequestedLoad) {
      _hasRequestedLoad = true;
      final authState = context.read<AuthBloc>().state;
      final userUID = authState.user?.uid ?? '';
      context.read<AccountBloc>().add(AccountEvent.loadAccountData(userUID));
    }
    if (!_hasRequestedUnreadCount) {
      _hasRequestedUnreadCount = true;
      final userUID = context.read<AuthBloc>().state.user?.uid ?? '';
      if (userUID.isNotEmpty) {
        context.read<MessagesBloc>().add(MessagesEvent.loadUnreadCount(userUID));
      }
    }
  }

  @override
  void deactivate() {
    _hasRequestedLoad = false;
    super.deactivate();
  }

  void _openPostDetail(Post post) {
    final accountBloc = context.read<AccountBloc>();
    final postId = post.id;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: accountBloc,
          child: BlocBuilder<AccountBloc, AccountState>(
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
                  context.read<AccountBloc>().add(
                        AccountEvent.likePostInAccount(
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
    final authState = context.read<AuthBloc>().state;
    final userUID = authState.user?.uid ?? '';

    return Container(
      decoration: const BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          // Return to Home screen (root) instead of exiting app
          context.go(AppRoutes.home);
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text('Account'),
            elevation: 0,
          ),
          body: SafeArea(
            child: BlocConsumer<AccountBloc, AccountState>(
            listenWhen: (prev, curr) => curr.errorMessage != prev.errorMessage,
            listener: (context, state) {
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
            },
            buildWhen: (prev, curr) =>
                prev.user != curr.user ||
                prev.preferences != curr.preferences ||
                prev.posts != curr.posts ||
                prev.isLoading != curr.isLoading ||
                prev.isLoadingPosts != curr.isLoadingPosts ||
                prev.isSaving != curr.isSaving ||
                prev.errorMessage != curr.errorMessage,
            builder: (context, state) {
              if (state.isLoading && state.user == null) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onBackground),
                  ),
                );
              }

              if (state.errorMessage != null && state.user == null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(spacingL),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: textPrimary,
                        ),
                        const SizedBox(height: spacingM),
                        Text(
                          'Error',
                          style: headlineMedium.copyWith(
                            color: textPrimary,
                          ),
                        ),
                        const SizedBox(height: spacingS),
                        Text(
                          state.errorMessage!,
                          style: bodyLarge.copyWith(
                            color: textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: spacingM),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<AccountBloc>()
                                .add(AccountEvent.loadAccountData(userUID));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentPink,
                            foregroundColor: surfaceColor,
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

              if (state.user != null && state.preferences != null) {
                final user = state.user!;
                final preferences = state.preferences!;
                final isSaving = state.isSaving;

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(spacingM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // User Profile Section
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(spacingM),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(cardBorderRadius),
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        color: primaryPurple,
                                        alignment: Alignment.center,
                                        child: Text(
                                          user.userName.isNotEmpty
                                              ? user.userName[0].toUpperCase()
                                              : '?',
                                          style: const TextStyle(
                                            fontSize: 32,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: spacingM),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user.userName,
                                            style: headlineMedium,
                                          ),
                                          const SizedBox(height: spacingXs),
                                          Text(
                                            user.userEmail,
                                            style: bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: spacingM),
                                Text(
                                  'Bio',
                                  style: labelLarge,
                                ),
                                const SizedBox(height: spacingXs),
                                Text(
                                  user.userBio,
                                  style: bodyLarge,
                                ),
                                if (user.userBioLink.isNotEmpty) ...[
                                  const SizedBox(height: spacingS),
                                  Text(
                                    'Link: ${user.userBioLink}',
                                    style: bodyMedium.copyWith(
                                      color: primaryPurple,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: spacingM),

                        // Dietary Preferences Section
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(spacingM),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dietary Preferences',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                const SizedBox(height: spacingM),
                                _buildPreferenceChip(
                                  context,
                                  'Vegetarian',
                                  preferences.vegetarian,
                                  (value) {
                                    final updated =
                                        preferences.copyWith(vegetarian: value);
                                    context
                                        .read<AccountBloc>()
                                        .add(AccountEvent.updateUserPreferences(updated));
                                  },
                                ),
                                _buildPreferenceChip(
                                  context,
                                  'Vegan',
                                  preferences.vegan,
                                  (value) {
                                    final updated =
                                        preferences.copyWith(vegan: value);
                                    context
                                        .read<AccountBloc>()
                                        .add(AccountEvent.updateUserPreferences(updated));
                                  },
                                ),
                                _buildPreferenceChip(
                                  context,
                                  'Halaal',
                                  preferences.halaal,
                                  (value) {
                                    final updated =
                                        preferences.copyWith(halaal: value);
                                    context
                                        .read<AccountBloc>()
                                        .add(AccountEvent.updateUserPreferences(updated));
                                  },
                                ),
                                _buildPreferenceChip(
                                  context,
                                  'No Pork',
                                  preferences.pork,
                                  (value) {
                                    final updated =
                                        preferences.copyWith(pork: value);
                                    context
                                        .read<AccountBloc>()
                                        .add(AccountEvent.updateUserPreferences(updated));
                                  },
                                ),
                                _buildPreferenceChip(
                                  context,
                                  'Lactose Free',
                                  preferences.lactose,
                                  (value) {
                                    final updated =
                                        preferences.copyWith(lactose: value);
                                    context
                                        .read<AccountBloc>()
                                        .add(AccountEvent.updateUserPreferences(updated));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: spacingM),

                        // Experience Preferences Section
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(spacingM),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Experience Preferences',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                const SizedBox(height: spacingM),
                                Wrap(
                                  spacing: spacingS,
                                  runSpacing: spacingS,
                                  children: [
                                    _buildPreferenceChip(
                                      context,
                                      'Outdoor',
                                      preferences.outdoor,
                                      (value) {
                                        final updated = preferences.copyWith(
                                            outdoor: value);
                                        context.read<AccountBloc>().add(
                                            AccountEvent.updateUserPreferences(updated));
                                      },
                                    ),
                                    _buildPreferenceChip(
                                      context,
                                      'Wine Tasting',
                                      preferences.wineTasting,
                                      (value) {
                                        final updated = preferences.copyWith(
                                            wineTasting: value);
                                        context.read<AccountBloc>().add(
                                            AccountEvent.updateUserPreferences(updated));
                                      },
                                    ),
                                    _buildPreferenceChip(
                                      context,
                                      'Wine Farms',
                                      preferences.wineFarms,
                                      (value) {
                                        final updated = preferences.copyWith(
                                            wineFarms: value);
                                        context.read<AccountBloc>().add(
                                            AccountEvent.updateUserPreferences(updated));
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: spacingM),
                                Text(
                                  'Cuisine Preferences',
                                  // labelLarge,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                const SizedBox(height: spacingS),
                                Wrap(
                                  spacing: spacingS,
                                  runSpacing: spacingS,
                                  children: [
                                    _buildPreferenceChip(
                                      context,
                                      'African',
                                      preferences.african,
                                      (value) {
                                        final updated = preferences.copyWith(
                                            african: value);
                                        context.read<AccountBloc>().add(
                                            AccountEvent.updateUserPreferences(updated));
                                      },
                                    ),
                                    _buildPreferenceChip(
                                      context,
                                      'Italian',
                                      preferences.italian,
                                      (value) {
                                        final updated = preferences.copyWith(
                                            italian: value);
                                        context.read<AccountBloc>().add(
                                            AccountEvent.updateUserPreferences(updated));
                                      },
                                    ),
                                    _buildPreferenceChip(
                                      context,
                                      'Greek',
                                      preferences.greek,
                                      (value) {
                                        final updated =
                                            preferences.copyWith(greek: value);
                                        context.read<AccountBloc>().add(
                                            AccountEvent.updateUserPreferences(updated));
                                      },
                                    ),
                                    _buildPreferenceChip(
                                      context,
                                      'Chinese',
                                      preferences.chinese,
                                      (value) {
                                        final updated = preferences.copyWith(
                                            chinese: value);
                                        context.read<AccountBloc>().add(
                                            AccountEvent.updateUserPreferences(updated));
                                      },
                                    ),
                                    _buildPreferenceChip(
                                      context,
                                      'Thai',
                                      preferences.thai,
                                      (value) {
                                        final updated =
                                            preferences.copyWith(thai: value);
                                        context.read<AccountBloc>().add(
                                            AccountEvent.updateUserPreferences(updated));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Privacy / Visibility Section
                        const SizedBox(height: spacingM),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(spacingM),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'What others can see',
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                const SizedBox(height: spacingS),
                                Text(
                                  'Control what appears when others view your profile.',
                                  style: bodyMedium.copyWith(color: textSecondary),
                                ),
                                const SizedBox(height: spacingM),
                                _buildPreferenceChip(
                                  context,
                                  'Profile (name, avatar)',
                                  preferences.showProfileToOthers,
                                  (value) {
                                    context.read<AccountBloc>().add(
                                          AccountEvent.updateUserPreferences(
                                            preferences.copyWith(showProfileToOthers: value),
                                          ),
                                        );
                                  },
                                ),
                                _buildPreferenceChip(
                                  context,
                                  'Bio',
                                  preferences.showBioToOthers,
                                  (value) {
                                    context.read<AccountBloc>().add(
                                          AccountEvent.updateUserPreferences(
                                            preferences.copyWith(showBioToOthers: value),
                                          ),
                                        );
                                  },
                                ),
                                _buildPreferenceChip(
                                  context,
                                  'Email',
                                  preferences.showEmailToOthers,
                                  (value) {
                                    context.read<AccountBloc>().add(
                                          AccountEvent.updateUserPreferences(
                                            preferences.copyWith(showEmailToOthers: value),
                                          ),
                                        );
                                  },
                                ),
                                _buildPreferenceChip(
                                  context,
                                  'Dietary & experience preferences',
                                  preferences.showPreferencesToOthers,
                                  (value) {
                                    context.read<AccountBloc>().add(
                                          AccountEvent.updateUserPreferences(
                                            preferences.copyWith(showPreferencesToOthers: value),
                                          ),
                                        );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: spacingL),
                        ProfilePostsGrid(
                          posts: state.posts,
                          isLoading: state.isLoadingPosts,
                          onPostTap: _openPostDetail,
                        ),

                        if (isSaving) ...[
                          const SizedBox(height: spacingM),
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(textPrimary),
                ),
              );
            },
          ),
          ),
          bottomNavigationBar: BlocBuilder<MessagesBloc, MessagesState>(
            buildWhen: (prev, curr) => prev.unreadCount != curr.unreadCount,
            builder: (context, messagesState) => BottomNavigationWidget(
              currentIndex: _currentTabIndex,
              onTabSelected: _handleTabSelected,
              unreadMessageCount: messagesState.unreadCount,
            ),
          ),
        ),
      )
    );
  }

  Widget _buildPreferenceChip(
    BuildContext context,
    String label,
    bool value,
    Function(bool) onChanged,
  ) {
    return FilterChip(
      label: Text(label),
      selected: value,
      onSelected: onChanged,
      selectedColor: primaryPurple.withOpacity(0.3),
      checkmarkColor: primaryPurple,
      labelStyle: TextStyle(
        color: value ? primaryPurple : textSecondary,
        fontWeight: value ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }
}
