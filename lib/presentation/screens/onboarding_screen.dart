import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/injection.dart' as di;
import '../../domain/entities/user_preference.dart';
import '../bloc/account/account_bloc.dart';
import '../bloc/account/account_event.dart';
import '../bloc/auth/auth_bloc.dart';
import '../router/app_router.dart';
import '../router/onboarding_session.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';
import '../theme/border_radius.dart';

/// Install-time onboarding: food types, diets, and preferences.
/// Shown on a fresh install before login; completion goes to Home with no back stack.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  late UserPreference _prefs;
  bool _isCompleting = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _prefs = UserPreference();
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

  Future<void> _complete() async {
    if (_isCompleting) return;
    setState(() => _isCompleting = true);
    HapticFeedback.mediumImpact();

    final user = context.read<AuthBloc>().state.user;
    if (user != null) {
      // Best-effort cloud sync when already signed in.
      context.read<AccountBloc>().add(
            AccountEvent.updateUserPreferences(
              _prefs.copyWith(
                id: user.uid,
                hasCompletedOnboardingThisInstall: true,
              ),
              markOnboardingComplete: true,
            ),
          );
    }

    // Local install flag + go_router replace → Home (no back to onboarding).
    await di.sl<OnboardingSession>().markComplete();
    if (!mounted) return;
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
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
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isCompleting ? null : _next,
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
                      child: _isCompleting
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
