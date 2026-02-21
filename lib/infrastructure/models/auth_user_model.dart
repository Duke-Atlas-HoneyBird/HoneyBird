import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  const AuthUserModel({
    required super.uid,
    required super.email,
    super.displayName,
    super.photoURL,
    required super.isEmailVerified,
  });

  factory AuthUserModel.fromFirebaseUser(User user) {
    return AuthUserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoURL: user.photoURL,
      isEmailVerified: user.emailVerified,
    );
  }

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'isEmailVerified': isEmailVerified,
    };
  }

  AuthUser toDomain() {
    return AuthUser(
      uid: uid,
      email: email,
      displayName: displayName,
      photoURL: photoURL,
      isEmailVerified: isEmailVerified,
    );
  }
}