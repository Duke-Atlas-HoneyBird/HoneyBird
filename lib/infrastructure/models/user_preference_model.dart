import '../../domain/entities/user_preference.dart';

/// Infrastructure model for UserPreference entity with local storage serialization.
/// 
/// Extends the domain UserPreference entity and adds JSON serialization capabilities
/// for local storage (SharedPreferences) integration.
class UserPreferenceModel extends UserPreference {
  UserPreferenceModel({
    super.id,
    super.hasCompletedOnboardingThisInstall = false,
    super.halaal = false,
    super.haram = false,
    super.pork = false,
    super.vegan = false,
    super.vegetarian = false,
    super.lactose = false,
    super.outdoor = false,
    super.wineTasting = false,
    super.wineFarms = false,
    super.african = true,
    super.chinese = true,
    super.greek = true,
    super.italian = true,
    super.thai = true,
    super.showProfileToOthers = true,
    super.showBioToOthers = true,
    super.showEmailToOthers = false,
    super.showPreferencesToOthers = true,
  });

  /// Creates a UserPreferenceModel from a JSON map (local storage).
  factory UserPreferenceModel.fromJson(Map<String, dynamic> json) {
    return UserPreferenceModel(
      id: json['id'] as String?,
      hasCompletedOnboardingThisInstall:
          json['hasCompletedOnboardingThisInstall'] as bool? ?? false,
      halaal: json['halaal'] as bool? ?? false,
      haram: json['haram'] as bool? ?? false,
      pork: json['pork'] as bool? ?? false,
      vegan: json['vegan'] as bool? ?? false,
      vegetarian: json['vegetarian'] as bool? ?? false,
      lactose: json['lactose'] as bool? ?? false,
      outdoor: json['outdoor'] as bool? ?? false,
      wineTasting: json['wineTasting'] as bool? ?? false,
      wineFarms: json['wineFarms'] as bool? ?? false,
      african: json['african'] as bool? ?? true,
      chinese: json['chinese'] as bool? ?? true,
      greek: json['greek'] as bool? ?? true,
      italian: json['italian'] as bool? ?? true,
      thai: json['thai'] as bool? ?? true,
      showProfileToOthers: json['showProfileToOthers'] as bool? ?? true,
      showBioToOthers: json['showBioToOthers'] as bool? ?? true,
      showEmailToOthers: json['showEmailToOthers'] as bool? ?? false,
      showPreferencesToOthers: json['showPreferencesToOthers'] as bool? ?? true,
    );
  }

  /// Converts this UserPreferenceModel to a JSON map for local storage.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hasCompletedOnboardingThisInstall': hasCompletedOnboardingThisInstall,
      'halaal': halaal,
      'haram': haram,
      'pork': pork,
      'vegan': vegan,
      'vegetarian': vegetarian,
      'lactose': lactose,
      'outdoor': outdoor,
      'wineTasting': wineTasting,
      'wineFarms': wineFarms,
      'african': african,
      'chinese': chinese,
      'greek': greek,
      'italian': italian,
      'thai': thai,
      'showProfileToOthers': showProfileToOthers,
      'showBioToOthers': showBioToOthers,
      'showEmailToOthers': showEmailToOthers,
      'showPreferencesToOthers': showPreferencesToOthers,
    };
  }

  /// Creates a UserPreferenceModel from a domain UserPreference entity.
  factory UserPreferenceModel.fromEntity(UserPreference preference) {
    return UserPreferenceModel(
      id: preference.id,
      hasCompletedOnboardingThisInstall:
          preference.hasCompletedOnboardingThisInstall,
      halaal: preference.halaal,
      haram: preference.haram,
      pork: preference.pork,
      vegan: preference.vegan,
      vegetarian: preference.vegetarian,
      lactose: preference.lactose,
      outdoor: preference.outdoor,
      wineTasting: preference.wineTasting,
      wineFarms: preference.wineFarms,
      african: preference.african,
      chinese: preference.chinese,
      greek: preference.greek,
      italian: preference.italian,
      thai: preference.thai,
      showProfileToOthers: preference.showProfileToOthers,
      showBioToOthers: preference.showBioToOthers,
      showEmailToOthers: preference.showEmailToOthers,
      showPreferencesToOthers: preference.showPreferencesToOthers,
    );
  }
}
