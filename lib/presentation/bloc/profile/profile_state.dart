import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/entities/user_preference.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isLoading,
    User? user,
    UserPreference? preferences,
    @Default(false) bool isBlocked,
    String? errorMessage,
  }) = _ProfileState;
}
