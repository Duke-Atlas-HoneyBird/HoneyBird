import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../state/account/account_bloc.dart';
import '../state/account/account_event.dart';
import '../state/account/account_state.dart';

/// Manage screen for managing user preferences
class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  int _currentTabIndex = 2; // Account/Manage area is index 2

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
        Navigator.pushReplacementNamed(context, '/account');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/messages');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc()..add(const LoadAccountData()),
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              'Manage',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is AccountLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
              }

              if (state is AccountError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingL),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.white,
                        ),
                        const SizedBox(height: AppTheme.spacingM),
                        Text(
                          'Error',
                          style: AppTheme.headlineMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacingS),
                        Text(
                          state.message,
                          style: AppTheme.bodyLarge.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppTheme.spacingM),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AccountBloc>().add(const LoadAccountData());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accentPink,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacingL,
                              vertical: AppTheme.spacingM,
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
                final preferences = state is AccountSaving
                    ? state.preferences
                    : (state as AccountLoaded).preferences;
                final isSaving = state is AccountSaving;

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<AccountBloc>().add(const LoadAccountData());
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  color: AppTheme.accentPink,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.spacingM),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Dietary Preferences Section
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(AppTheme.spacingM),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Dietary Preferences',
                                    style: AppTheme.headlineMedium,
                                  ),
                                  const SizedBox(height: AppTheme.spacingM),
                                  Wrap(
                                    spacing: AppTheme.spacingS,
                                    runSpacing: AppTheme.spacingS,
                                    children: [
                                      _buildPreferenceChip(
                                        context,
                                        'Vegetarian',
                                        preferences.vegetarian,
                                        (value) {
                                          final updated = preferences.copyWith(vegetarian: value);
                                          context.read<AccountBloc>().add(UpdateUserPreferences(updated));
                                        },
                                      ),
                                      _buildPreferenceChip(
                                        context,
                                        'Vegan',
                                        preferences.vegan,
                                        (value) {
                                          final updated = preferences.copyWith(vegan: value);
                                          context.read<AccountBloc>().add(UpdateUserPreferences(updated));
                                        },
                                      ),
                                      _buildPreferenceChip(
                                        context,
                                        'Halaal',
                                        preferences.halaal,
                                        (value) {
                                          final updated = preferences.copyWith(halaal: value);
                                          context.read<AccountBloc>().add(UpdateUserPreferences(updated));
                                        },
                                      ),
                                      _buildPreferenceChip(
                                        context,
                                        'No Pork',
                                        preferences.pork,
                                        (value) {
                                          final updated = preferences.copyWith(pork: value);
                                          context.read<AccountBloc>().add(UpdateUserPreferences(updated));
                                        },
                                      ),
                                      _buildPreferenceChip(
                                        context,
                                        'Lactose Free',
                                        preferences.lactose,
                                        (value) {
                                          final updated = preferences.copyWith(lactose: value);
                                          context.read<AccountBloc>().add(UpdateUserPreferences(updated));
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingM),

                          // Experience Preferences Section
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(AppTheme.spacingM),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Experience Preferences',
                                    style: AppTheme.headlineMedium,
                                  ),
                                  const SizedBox(height: AppTheme.spacingM),
                                  Wrap(
                                    spacing: AppTheme.spacingS,
                                    runSpacing: AppTheme.spacingS,
                                    children: [
                                      _buildPreferenceChip(
                                        context,
                                        'Outdoor',
                                        preferences.outdoor,
                                        (value) {
                                          final updated = preferences.copyWith(outdoor: value);
                                          context.read<AccountBloc>().add(UpdateUserPreferences(updated));
                                        },
                                      ),
                                      _buildPreferenceChip(
                                        context,
                                        'Wine Tasting',
                                        preferences.wineTasting,
                                        (value) {
                                          final updated = preferences.copyWith(wineTasting: value);
                                          context.read<AccountBloc>().add(UpdateUserPreferences(updated));
                                        },
                                      ),
                                      _buildPreferenceChip(
                                        context,
                                        'Wine Farms',
                                        preferences.wineFarms,
                                        (value) {
                                          final updated = preferences.copyWith(wineFarms: value);
                                          context.read<AccountBloc>().add(UpdateUserPreferences(updated));
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingM),

                          // Cuisine Preferences Section
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(AppTheme.spacingM),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Cuisine Preferences',
                                    style: AppTheme.headlineMedium,
                                  ),
                                  const SizedBox(height: AppTheme.spacingM),
                                  Wrap(
                                    spacing: AppTheme.spacingS,
                                    runSpacing: AppTheme.spacingS,
                                    children: [
                                      _buildPreferenceChip(
                                        context,
                                        'African',
                                        preferences.african,
                                        (value) {
                                          final updated = preferences.copyWith(african: value);
                                          context.read<AccountBloc>().add(UpdateUserPreferences(updated));
                                        },
                                      ),
                                      _buildPreferenceChip(
                                        context,
                                        'Italian',
                                        preferences.italian,
                                        (value) {
                                          final updated = preferences.copyWith(italian: value);
                                          context.read<AccountBloc>().add(UpdateUserPreferences(updated));
                                        },
                                      ),
                                      _buildPreferenceChip(
                                        context,
                                        'Greek',
                                        preferences.greek,
                                        (value) {
                                          final updated = preferences.copyWith(greek: value);
                                          context.read<AccountBloc>().add(UpdateUserPreferences(updated));
                                        },
                                      ),
                                      _buildPreferenceChip(
                                        context,
                                        'Chinese',
                                        preferences.chinese,
                                        (value) {
                                          final updated = preferences.copyWith(chinese: value);
                                          context.read<AccountBloc>().add(UpdateUserPreferences(updated));
                                        },
                                      ),
                                      _buildPreferenceChip(
                                        context,
                                        'Thai',
                                        preferences.thai,
                                        (value) {
                                          final updated = preferences.copyWith(thai: value);
                                          context.read<AccountBloc>().add(UpdateUserPreferences(updated));
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          if (isSaving) ...[
                            const SizedBox(height: AppTheme.spacingM),
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        ],
                      ),
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
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              HapticFeedback.mediumImpact();
              // Handle create action - could navigate to create preference or other action
            },
            elevation: AppTheme.fabElevation,
            label: const Text('Create'),
            icon: const Icon(Icons.add_outlined),
            heroTag: 'manageCreateFAB',
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          bottomNavigationBar: BottomNavigationWidget(
            currentIndex: _currentTabIndex,
            onTabSelected: _handleTabSelected,
          ),
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
      onSelected: (selected) {
        HapticFeedback.lightImpact();
        onChanged(selected);
      },
      selectedColor: AppTheme.primaryPurple.withValues(alpha: 0.3),
      checkmarkColor: AppTheme.primaryPurple,
      labelStyle: TextStyle(
        color: value ? AppTheme.primaryPurple : AppTheme.textSecondary,
        fontWeight: value ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }
}
