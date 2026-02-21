import 'package:equatable/equatable.dart';

/// Domain entity representing an authenticated user.
/// 
/// This entity is immutable and uses value equality for comparison.
/// Represents the authentication state and basic user information.
class AuthUser extends Equatable {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoURL;
  final bool isEmailVerified;

  const AuthUser({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoURL,
    required this.isEmailVerified,
  });

  @override
  List<Object?> get props => [
        uid,
        email,
        displayName,
        photoURL,
        isEmailVerified,
      ];
}