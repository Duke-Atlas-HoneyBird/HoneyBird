import 'package:dartz/dartz.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/error/failures.dart';
import '../data_sources/firebase_auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _authDataSource;

  AuthRepositoryImpl({required FirebaseAuthDataSource authDataSource})
      : _authDataSource = authDataSource;

  @override
  Future<Either<Failure, AuthUser?>> getCurrentUser() async {
    try {
      final userModel = await _authDataSource.getCurrentUser();
      return Right(userModel?.toDomain());
    } catch (e) {
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
      return Right(userModel.toDomain());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await _authDataSource.sendPasswordResetEmail(email);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    try {
      await _authDataSource.sendEmailVerification();
      return const Right(null);
    } catch (e) {
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