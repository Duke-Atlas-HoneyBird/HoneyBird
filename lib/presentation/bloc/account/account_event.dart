import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/user_preference.dart';

part 'account_event.freezed.dart';

@freezed
class AccountEvent with _$AccountEvent {
  const factory AccountEvent.loadAccountData(String userUID) = LoadAccountData;
  const factory AccountEvent.updateUserPreferences(
    UserPreference preferences, {
    @Default(false) bool markOnboardingComplete,
  }) = UpdateUserPreferences;
  const factory AccountEvent.updateUserProfile({
    required String userName,
    required String userBio,
    required String userBioLink,
  }) = UpdateUserProfile;
  const factory AccountEvent.checkOnboardingStatus(String userUID) =
      CheckOnboardingStatus;
}
