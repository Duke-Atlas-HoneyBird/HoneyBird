import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/constants.dart';

/// Firebase data source for block operations.
abstract class FirebaseBlockDataSource {
  Future<void> blockUser(String currentUserUID, String blockedUserUID);
  Future<void> unblockUser(String currentUserUID, String blockedUserUID);
  Future<List<String>> getBlockedUserIds(String currentUserUID);
  Future<bool> isBlocked(String currentUserUID, String targetUserUID);
}

class FirebaseBlockDataSourceImpl implements FirebaseBlockDataSource {
  final FirebaseFirestore _firestore;

  FirebaseBlockDataSourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference _userBlockedRef(String userUID) =>
      _firestore
          .collection(FirebaseCollections.users)
          .doc(userUID)
          .collection(FirebaseCollections.blocked);

  @override
  Future<void> blockUser(String currentUserUID, String blockedUserUID) async {
    try {
      await _userBlockedRef(currentUserUID).doc(blockedUserUID).set({
        'blockedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw ServerException('Failed to block user: $e');
    }
  }

  @override
  Future<void> unblockUser(String currentUserUID, String blockedUserUID) async {
    try {
      await _userBlockedRef(currentUserUID).doc(blockedUserUID).delete();
    } catch (e) {
      throw ServerException('Failed to unblock user: $e');
    }
  }

  @override
  Future<List<String>> getBlockedUserIds(String currentUserUID) async {
    try {
      final snapshot =
          await _userBlockedRef(currentUserUID).get();
      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      throw ServerException('Failed to get blocked users: $e');
    }
  }

  @override
  Future<bool> isBlocked(String currentUserUID, String targetUserUID) async {
    try {
      final doc = await _userBlockedRef(currentUserUID)
          .doc(targetUserUID)
          .get();
      return doc.exists;
    } catch (e) {
      throw ServerException('Failed to check block status: $e');
    }
  }
}
