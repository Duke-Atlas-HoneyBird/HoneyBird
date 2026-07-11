import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/entities/user_preference.dart';

part 'account_state.freezed.dart';

@freezed
class AccountState with _$AccountState {
  const factory AccountState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingPosts,
    @Default(false) bool isSaving,
    User? user,
    UserPreference? preferences,
    @Default([]) List<Post> posts,
    String? errorMessage,
    /// True if user has completed onboarding (has saved preferences).
    bool? hasCompletedOnboarding,
  }) = _AccountState;
}
