import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_preference.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/repositories/user_preference_repository.dart';
import '../../core/error/failures.dart';
import '../../core/utils/constants.dart';
import '../data_sources/firebase_auth_data_source.dart';
import '../models/user_preference_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _authDataSource;
  final UserRepository _userRepository;
  final UserPreferenceRepository _preferenceRepository;
  final SharedPreferences _sharedPreferences;

  AuthRepositoryImpl({
    required FirebaseAuthDataSource authDataSource,
    required UserRepository userRepository,
    required UserPreferenceRepository preferenceRepository,
    required SharedPreferences sharedPreferences,
  })  : _authDataSource = authDataSource,
        _userRepository = userRepository,
        _preferenceRepository = preferenceRepository,
        _sharedPreferences = sharedPreferences;

  @override
  Future<Either<Failure, AuthUser?>> getCurrentUser() async {
    try {
      final userModel = await _authDataSource.getCurrentUser();
      final user = userModel?.toDomain();
      if (user != null) {
        await _applyPendingPreferences(user.uid);
      }
      return Right(user);
    } catch (e) {
      print('[AuthRepositoryImpl] getCurrentUser: ${e.toString()}');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _authDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final authUser = userModel.toDomain();
      await _applyPendingPreferences(authUser.uid);
      return Right(authUser);
    } catch (e) {
      print('[AuthRepositoryImpl] signInWithEmailAndPassword: ${e.toString()}');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final userModel = await _authDataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName,
      );
      final authUser = userModel.toDomain();
      final userUID = authUser.uid;
      final userName = displayName?.trim().isNotEmpty == true
          ? displayName!.trim()
          : email.split('@').first;

      // Create User document in Firestore (doc ID = auth UID)
      final user = User(
        userName: userName,
        userBio: '',
        userBioLink: '',
        userUID: userUID,
        userEmail: email,
      );
      final userResult = await _userRepository.createUserWithId(userUID, user);
      userResult.fold(
        (e) => print('[AuthRepositoryImpl] createUser failed: $e'),
        (_) {},
      );

      // Prefer taste choices collected on the preferences screens.
      final appliedPending = await _applyPendingPreferences(userUID);
      if (!appliedPending) {
        final preferences = UserPreference(id: userUID);
        final prefResult =
            await _preferenceRepository.savePreferences(preferences);
        prefResult.fold(
          (e) => print('[AuthRepositoryImpl] savePreferences failed: $e'),
          (_) {},
        );
      }

      return Right(authUser);
    } catch (e) {
      print('[AuthRepositoryImpl] signUpWithEmailAndPassword: ${e.toString()}');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authDataSource.signOut();
      return const Right(null);
    } catch (e) {
      print('[AuthRepositoryImpl] signOut: ${e.toString()}');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await _authDataSource.sendPasswordResetEmail(email);
      return const Right(null);
    } catch (e) {
      print('[AuthRepositoryImpl] sendPasswordResetEmail: ${e.toString()}');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    try {
      await _authDataSource.sendEmailVerification();
      return const Right(null);
    } catch (e) {
      print('[AuthRepositoryImpl] sendEmailVerification: ${e.toString()}');
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Writes pre-auth taste choices onto [userId]. Returns false when there are none.
  Future<bool> _applyPendingPreferences(String userId) async {
    final raw =
        _sharedPreferences.getString(StorageKeys.pendingOnboardingPreferences);
    if (raw == null || raw.isEmpty) return false;

    try {
      final decoded = json.decode(raw);
      if (decoded is! Map) {
        await _sharedPreferences
            .remove(StorageKeys.pendingOnboardingPreferences);
        return false;
      }
      final pending = UserPreferenceModel.fromJson(
        Map<String, dynamic>.from(decoded),
      );
      final preferences = UserPreferenceModel.fromEntity(
        pending.copyWith(
          id: userId,
          hasCompletedOnboardingThisInstall: true,
        ),
      );
      final result = await _preferenceRepository.savePreferences(preferences);
      return await result.fold<Future<bool>>(
        (failure) async {
          print('[AuthRepositoryImpl] pending preferences: $failure');
          return false;
        },
        (_) async {
          await _sharedPreferences
              .remove(StorageKeys.pendingOnboardingPreferences);
          return true;
        },
      );
    } catch (e) {
      print('[AuthRepositoryImpl] pending preferences: $e');
      await _sharedPreferences.remove(StorageKeys.pendingOnboardingPreferences);
      return false;
    }
  }

  @override
  Stream<AuthUser?> get authStateChanges {
    return _authDataSource.authStateChanges.map((userModel) {
      return userModel?.toDomain();
    });
  }
}
