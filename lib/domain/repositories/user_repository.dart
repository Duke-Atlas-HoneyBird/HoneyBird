import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../core/error/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser(String userId);
  /// Get user by Firebase Auth UID (userUID field).
  Future<Either<Failure, User>> getUserByUID(String userUID);
  Future<Either<Failure, User>> createUser(User user);
  /// Create user with doc ID = userUID (e.g. Firebase Auth UID). For sign-up flow.
  Future<Either<Failure, User>> createUserWithId(String userUID, User user);
  Future<Either<Failure, User>> updateUser(User user);
  Future<Either<Failure, void>> deleteUser(String userId);
}
