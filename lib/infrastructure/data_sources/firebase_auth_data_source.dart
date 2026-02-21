import 'package:firebase_auth/firebase_auth.dart';
import '../models/auth_user_model.dart';

abstract class FirebaseAuthDataSource {
  Future<AuthUserModel?> getCurrentUser();
  Future<AuthUserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<AuthUserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  });
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> sendEmailVerification();
  Stream<AuthUserModel?> get authStateChanges;
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSourceImpl({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<AuthUserModel?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      return user != null ? AuthUserModel.fromFirebaseUser(user) : null;
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  @override
  Future<AuthUserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user == null) {
        throw Exception('Sign in failed: No user returned');
      }
      
      return AuthUserModel.fromFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw Exception('Sign in failed: ${e.message}');
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  @override
  Future<AuthUserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user == null) {
        throw Exception('Sign up failed: No user returned');
      }

      // Update display name if provided
      if (displayName != null) {
        await credential.user!.updateDisplayName(displayName);
        await credential.user!.reload();
      }
      
      return AuthUserModel.fromFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw Exception('Sign up failed: ${e.message}');
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception('Password reset failed: ${e.message}');
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('No user signed in');
      }
      await user.sendEmailVerification();
    } catch (e) {
      throw Exception('Email verification failed: $e');
    }
  }

  @override
  Stream<AuthUserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) {
      return user != null ? AuthUserModel.fromFirebaseUser(user) : null;
    });
  }
}