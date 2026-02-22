import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/auth_user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    AuthUser? user,
    String? errorMessage,
    String? passwordResetEmail,
    @Default(false) bool emailVerificationSent,
  }) = _AuthState;
}
