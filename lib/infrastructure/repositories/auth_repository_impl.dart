import 'package:dartz/dartz.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_preference.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/repositories/user_preference_repository.dart';
import '../../core/error/failures.dart';
import '../data_sources/firebase_auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _authDataSource;
  final UserRepository _userRepository;
  final UserPreferenceRepository _preferenceRepository;

  AuthRepositoryImpl({
    required FirebaseAuthDataSource authDataSource,
    required UserRepository userRepository,
    required UserPreferenceRepository preferenceRepository,
  })  : _authDataSource = authDataSource,
        _userRepository = userRepository,
        _preferenceRepository = preferenceRepository;

  @override
  Future<Either<Failure, AuthUser?>> getCurrentUser() async {
    try {
      final userModel = await _authDataSource.getCurrentUser();
      return Right(userModel?.toDomain());
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
      return Right(userModel.toDomain());
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
      final trimmedDisplayName = displayName?.trim();
      final userName = (trimmedDisplayName != null && trimmedDisplayName.isNotEmpty)
          ? trimmedDisplayName
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

      // Create default UserPreference in Firestore
      final preferences = UserPreference(id: userUID);
      final prefResult = await _preferenceRepository.savePreferences(preferences);
      prefResult.fold(
        (e) => print('[AuthRepositoryImpl] savePreferences failed: $e'),
        (_) {},
      );

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

  @override
  Stream<AuthUser?> get authStateChanges {
    return _authDataSource.authStateChanges.map((userModel) {
      return userModel?.toDomain();
    });
  }
}