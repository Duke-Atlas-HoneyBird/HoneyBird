import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/repositories/block_repository.dart';
import '../data_sources/firebase_block_data_source.dart';

class BlockRepositoryImpl implements BlockRepository {
  final FirebaseBlockDataSource _dataSource;

  BlockRepositoryImpl({required FirebaseBlockDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Either<Failure, void>> blockUser(
      String currentUserUID, String blockedUserUID) async {
    try {
      await _dataSource.blockUser(currentUserUID, blockedUserUID);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to block user: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> unblockUser(
      String currentUserUID, String blockedUserUID) async {
    try {
      await _dataSource.unblockUser(currentUserUID, blockedUserUID);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to unblock user: $e'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getBlockedUserIds(
      String currentUserUID) async {
    try {
      final ids = await _dataSource.getBlockedUserIds(currentUserUID);
      return Right(ids);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to get blocked users: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isBlocked(
      String currentUserUID, String targetUserUID) async {
    try {
      final result =
          await _dataSource.isBlocked(currentUserUID, targetUserUID);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to check block status: $e'));
    }
  }
}
