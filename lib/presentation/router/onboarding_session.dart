import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/constants.dart';

/// Tracks whether install-time onboarding has been completed (local only).
/// Used by [GoRouter] redirects and refreshed when onboarding finishes.
class OnboardingSession extends ChangeNotifier {
  OnboardingSession(this._prefs)
      : completed =
            _prefs.getBool(StorageKeys.hasCompletedOnboardingThisInstall) ??
                false;

  final SharedPreferences _prefs;

  bool completed;

  Future<void> markComplete() async {
    await _prefs.setBool(StorageKeys.hasCompletedOnboardingThisInstall, true);
    if (completed) return;
    completed = true;
    notifyListeners();
  }
}
