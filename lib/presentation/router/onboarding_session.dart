import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/constants.dart';
import '../../domain/entities/user_preference.dart';
import '../../infrastructure/models/user_preference_model.dart';

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

  /// Keeps taste choices chosen before an account exists.
  Future<void> savePendingPreferences(UserPreference preference) async {
    final model = UserPreferenceModel.fromEntity(
      preference.copyWith(hasCompletedOnboardingThisInstall: true),
    );
    await _prefs.setString(
      StorageKeys.pendingOnboardingPreferences,
      json.encode(model.toJson()),
    );
  }
}
