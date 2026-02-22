import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';

/// Repository for blocking/unblocking users.
abstract class BlockRepository {
  /// Block a user. Current user will no longer see their content.
  Future<Either<Failure, void>> blockUser(String currentUserUID, String blockedUserUID);

  /// Unblock a user.
  Future<Either<Failure, void>> unblockUser(String currentUserUID, String blockedUserUID);

  /// Get list of user UIDs that current user has blocked.
  Future<Either<Failure, List<String>>> getBlockedUserIds(String currentUserUID);

  /// Check if a user is blocked.
  Future<Either<Failure, bool>> isBlocked(String currentUserUID, String targetUserUID);
}
