import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/firebase_user_data_source.dart';
import '../models/user_model.dart';

/// Implementation of UserRepository that uses Firebase as the data source
class UserRepositoryImpl implements UserRepository {
  final FirebaseUserDataSource _firebaseDataSource;

  UserRepositoryImpl({required FirebaseUserDataSource firebaseDataSource})
      : _firebaseDataSource = firebaseDataSource;

  @override
  Future<Either<Failure, User>> getUser(String userId) async {
    try {
      final userModel = await _firebaseDataSource.getUser(userId);
      return Right(userModel.toDomain());
    } on ServerException catch (e) {
      print('[UserRepositoryImpl] getUser ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[UserRepositoryImpl] getUser unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> createUser(User user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final createdUser = await _firebaseDataSource.createUser(userModel);
      return Right(createdUser.toDomain());
    } on ServerException catch (e) {
      print('[UserRepositoryImpl] createUser ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[UserRepositoryImpl] createUser unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(User user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final updatedUser = await _firebaseDataSource.updateUser(userModel);
      return Right(updatedUser.toDomain());
    } on ServerException catch (e) {
      print('[UserRepositoryImpl] updateUser ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[UserRepositoryImpl] updateUser unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String userId) async {
    try {
      await _firebaseDataSource.deleteUser(userId);
      return const Right(null);
    } on ServerException catch (e) {
      print('[UserRepositoryImpl] deleteUser ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[UserRepositoryImpl] deleteUser unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }
}
