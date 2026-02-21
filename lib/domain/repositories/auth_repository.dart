import 'package:dartz/dartz.dart';
import '../entities/auth_user.dart';
import '../../core/error/failures.dart';

abstract class AuthRepository {
  /// Get current authenticated user
  Future<Either<Failure, AuthUser?>> getCurrentUser();
  
  /// Sign in with email and password
  Future<Either<Failure, AuthUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  /// Sign up with email and password
  Future<Either<Failure, AuthUser>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  });
  
  /// Sign out current user
  Future<Either<Failure, void>> signOut();
  
  /// Send password reset email
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);
  
  /// Send email verification
  Future<Either<Failure, void>> sendEmailVerification();
  
  /// Stream of authentication state changes
  Stream<AuthUser?> get authStateChanges;
}