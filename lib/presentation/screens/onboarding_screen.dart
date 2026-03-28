import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/snackbar_utils.dart';
import '../../domain/entities/user_preference.dart';
import '../bloc/account/account_bloc.dart';
import '../bloc/account/account_event.dart';
import '../bloc/account/account_state.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';
import '../theme/border_radius.dart';

/// Spotify-style onboarding: food types, diets, and preferences.
/// Shown after sign-up until user completes; then preferences are saved and user goes to Home.
class OnboardingScreen extends StatefulWidget {
  final String userId;

  const OnboardingScreen({
    super.key,
    required this.userId,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  late UserPreference _prefs;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _prefs = UserPreference(id: widget.userId);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    HapticFeedback.lightImpact();
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage++;
      });
    } else {
      _complete();
    }
  }

  void _complete() {
    HapticFeedback.mediumImpact();
    context.read<AccountBloc>().add(
          AccountEvent.updateUserPreferences(
            _prefs,
            markOnboardingComplete: true,
          ),
        );

    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listenWhen: (prev, curr) =>
          (prev.isSaving == true && curr.isSaving == false) ||
          (prev.errorMessage != curr.errorMessage && curr.errorMessage != null),
      listener: (context, state) {
        if (state.errorMessage != null && !state.isSaving) {
          SnackBarUtils.showError(
            context,
            'Could not save preferences. Try again.',
          );
          return;
        }
        // Save completed successfully (was saving, now done, no error)
        if (!state.isSaving && state.errorMessage == null && state.hasCompletedOnboarding == true) {
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: spacingL),
                Text(
                  'Tell us about your taste',
                  style: headlineMedium.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: spacingS),
                Text(
                  'We\'ll use this to personalize your feed',
                  style: bodyMedium.copyWith(color: textSecondary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: spacingL),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    children: [
                      _buildCuisinesPage(),
                      _buildDietPage(),
                      _buildExperiencesPage(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(spacingL),
                  child: Row(
                    children: [
                      ...List.generate(3, (i) {
                        return Container(
                          margin: const EdgeInsets.only(right: 6),
                          width: _currentPage == i ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: _currentPage == i
                                ? accentPink
                                : textSecondary.withValues(alpha: 0.3),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      spacingL, 0, spacingL, spacingL),
                  child: BlocBuilder<AccountBloc, AccountState>(
                    buildWhen: (prev, curr) => prev.isSaving != curr.isSaving,
                    builder: (context, state) {
                      final isSaving = state.isSaving;
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isSaving ? null : _next,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentPink,
                            foregroundColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(vertical: spacingM),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(buttonBorderRadius),
                            ),
                            minimumSize: const Size.fromHeight(48),
                          ),
                          child: isSaving
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : Text(
                                  _currentPage < 2 ? 'Next' : 'Get started',
                                  style: labelLarge.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCuisinesPage() {
    final cuisines = [
      ('African', 'african'),
      ('Italian', 'italian'),
      ('Greek', 'greek'),
      ('Chinese', 'chinese'),
      ('Thai', 'thai'),
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What cuisines do you enjoy?',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: spacingM),
          Wrap(
            spacing: spacingS,
            runSpacing: spacingS,
            children: cuisines.map((e) {
              final key = e.$2;
              final value = _getPrefValue(key);
              return FilterChip(
                label: Text(e.$1),
                selected: value,
                onSelected: (v) {
                  setState(() {
                    _prefs = _setPrefValue(key, v);
                  });
                },
                selectedColor: starGold.withValues(alpha: 0.25),
                checkmarkColor: starGold,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDietPage() {
    final diets = [
      ('Vegetarian', 'vegetarian'),
      ('Vegan', 'vegan'),
      ('Halal', 'halaal'),
      ('No pork', 'pork'),
      ('Lactose-free', 'lactose'),
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Any dietary preferences?',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: spacingM),
          Wrap(
            spacing: spacingS,
            runSpacing: spacingS,
            children: diets.map((e) {
              final key = e.$2;
              final value = _getPrefValue(key);
              return FilterChip(
                label: Text(e.$1),
                selected: value,
                onSelected: (v) {
                  setState(() {
                    _prefs = _setPrefValue(key, v);
                  });
                },
                selectedColor: starGold.withValues(alpha: 0.25),
                checkmarkColor: starGold,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildExperiencesPage() {
    final experiences = [
      ('Outdoor dining', 'outdoor'),
      ('Wine tasting', 'wineTasting'),
      ('Wine farms', 'wineFarms'),
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What experiences do you like?',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: spacingM),
          Wrap(
            spacing: spacingS,
            runSpacing: spacingS,
            children: experiences.map((e) {
              final key = e.$2;
              final value = _getPrefValue(key);
              return FilterChip(
                label: Text(e.$1),
                selected: value,
                onSelected: (v) {
                  setState(() {
                    _prefs = _setPrefValue(key, v);
                  });
                },
                selectedColor: starGold.withValues(alpha: 0.25),
                checkmarkColor: starGold,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  bool _getPrefValue(String key) {
    switch (key) {
      case 'african':
        return _prefs.african;
      case 'italian':
        return _prefs.italian;
      case 'greek':
        return _prefs.greek;
      case 'chinese':
        return _prefs.chinese;
      case 'thai':
        return _prefs.thai;
      case 'vegetarian':
        return _prefs.vegetarian;
      case 'vegan':
        return _prefs.vegan;
      case 'halaal':
        return _prefs.halaal;
      case 'pork':
        return _prefs.pork;
      case 'lactose':
        return _prefs.lactose;
      case 'outdoor':
        return _prefs.outdoor;
      case 'wineTasting':
        return _prefs.wineTasting;
      case 'wineFarms':
        return _prefs.wineFarms;
      default:
        return false;
    }
  }

  UserPreference _setPrefValue(String key, bool value) {
    switch (key) {
      case 'african':
        return _prefs.copyWith(african: value);
      case 'italian':
        return _prefs.copyWith(italian: value);
      case 'greek':
        return _prefs.copyWith(greek: value);
      case 'chinese':
        return _prefs.copyWith(chinese: value);
      case 'thai':
        return _prefs.copyWith(thai: value);
      case 'vegetarian':
        return _prefs.copyWith(vegetarian: value);
      case 'vegan':
        return _prefs.copyWith(vegan: value);
      case 'halaal':
        return _prefs.copyWith(halaal: value);
      case 'pork':
        return _prefs.copyWith(pork: value);
      case 'lactose':
        return _prefs.copyWith(lactose: value);
      case 'outdoor':
        return _prefs.copyWith(outdoor: value);
      case 'wineTasting':
        return _prefs.copyWith(wineTasting: value);
      case 'wineFarms':
        return _prefs.copyWith(wineFarms: value);
      default:
        return _prefs;
    }
  }
}
