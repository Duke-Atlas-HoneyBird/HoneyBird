import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.checkRequested() = AuthCheckRequested;
  const factory AuthEvent.signInRequested({
    required String email,
    required String password,
  }) = AuthSignInRequested;
  const factory AuthEvent.signUpRequested({
    required String email,
    required String password,
    String? displayName,
  }) = AuthSignUpRequested;
  const factory AuthEvent.signOutRequested() = AuthSignOutRequested;
  const factory AuthEvent.passwordResetRequested({required String email}) =
      AuthPasswordResetRequested;
  const factory AuthEvent.emailVerificationRequested() =
      AuthEmailVerificationRequested;
  const factory AuthEvent.userChanged(dynamic user) = AuthUserChanged;
}
