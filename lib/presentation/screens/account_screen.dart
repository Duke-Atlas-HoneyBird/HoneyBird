import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/colours.dart';
import '../theme/text_styles.dart';
import '../theme/spacing.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../state/account/account_bloc.dart';
import '../state/account/account_event.dart';
import '../state/account/account_state.dart';

import '../../core/di/injection.dart';
import '../state/auth/auth_bloc.dart';
import '../state/auth/auth_state.dart';

/// Account screen for managing user account settings
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _currentTabIndex = 2;
  bool _hasRequestedLoad = false;

  void _handleTabSelected(int index) {
    if (_currentTabIndex == index) {
      return;
    }

    setState(() {
      _currentTabIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/favorites');
        break;
      case 2:
        // Already on Account screen
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/messages');
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasRequestedLoad) {
      _hasRequestedLoad = true;
      final authState = context.read<AuthBloc>().state;
      final userUID = authState is AuthAuthenticated ? authState.user.uid : '';
      context.read<AccountBloc>().add(LoadAccountData(userUID));
    }
  }

  @override
  void deactivate() {
    _hasRequestedLoad = false;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    String userUID = '';
    if (authState is AuthAuthenticated) {
      userUID = authState.user.uid;
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Account'),
            elevation: 0,
          ),
          body: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is AccountLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onBackground),
                  ),
                );
              }

              if (state is AccountError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(spacingL),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.white,
                        ),
                        const SizedBox(height: spacingM),
                        Text(
                          'Error',
                          style: headlineMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: spacingS),
                        Text(
                          state.message,
                          style: bodyLarge.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: spacingM),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<AccountBloc>()
                                .add(LoadAccountData(userUID));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentPink,
                            foregroundColor: Colors.white,
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

              if (state is AccountLoaded || state is AccountSaving) {
                final user = state is AccountSaving
                    ? state.user
                    : (state as AccountLoaded).user;
                final preferences = state is AccountSaving
                    ? state.preferences
                    : (state as AccountLoaded).preferences;
                final isSaving = state is AccountSaving;

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
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: primaryPurple,
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
                                        .add(UpdateUserPreferences(updated));
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
                                        .add(UpdateUserPreferences(updated));
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
                                        .add(UpdateUserPreferences(updated));
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
                                        .add(UpdateUserPreferences(updated));
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
                                        .add(UpdateUserPreferences(updated));
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
                                            UpdateUserPreferences(updated));
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
                                            UpdateUserPreferences(updated));
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
                                            UpdateUserPreferences(updated));
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
                                            UpdateUserPreferences(updated));
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
                                            UpdateUserPreferences(updated));
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
                                            UpdateUserPreferences(updated));
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
                                            UpdateUserPreferences(updated));
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
                                            UpdateUserPreferences(updated));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            },
          ),
          bottomNavigationBar: BottomNavigationWidget(
            currentIndex: _currentTabIndex,
            onTabSelected: _handleTabSelected,
          ),
        ),
    
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
