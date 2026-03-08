import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/error/exceptions.dart';
import '../../core/utils/constants.dart';
import '../models/user_model.dart';

/// Abstract interface for Firebase user data operations
abstract class FirebaseUserDataSource {
  /// Retrieves a user from Firestore by document ID
  Future<UserModel> getUser(String userId);

  /// Retrieves a user from Firestore by Firebase Auth UID (userUID field)
  Future<UserModel> getUserByUID(String userUID);

  /// Creates a new user in Firestore
  Future<UserModel> createUser(UserModel user);

  /// Creates a user with a specific document ID (e.g. Firebase Auth UID).
  /// Used for sign-up so doc ID matches auth.uid for Firestore rules.
  Future<UserModel> createUserWithId(String docId, UserModel user);

  /// Updates an existing user in Firestore
  Future<UserModel> updateUser(UserModel user);

  /// Deletes a user from Firestore
  Future<void> deleteUser(String userId);
}

/// Implementation of FirebaseUserDataSource using Cloud Firestore
class FirebaseUserDataSourceImpl implements FirebaseUserDataSource {
  final FirebaseFirestore _firestore;

  FirebaseUserDataSourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<UserModel> getUser(String userId) async {
    try {
      final doc = await _firestore
          .collection(FirebaseCollections.users)
          .doc(userId)
          .get();

      if (!doc.exists) {
        throw ServerException('User not found with ID: $userId');
      }

      final data = doc.data();
      if (data == null) {
        throw ServerException('User data is null for ID: $userId');
      }

      return UserModel.fromJson({...data, 'id': doc.id});
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error getting user by UID: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to get user: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> getUserByUID(String userUID) async {
    try {
      // Try direct doc lookup first (users are often stored with doc ID = Auth UID)
      final docRef = _firestore
          .collection(FirebaseCollections.users)
          .doc(userUID);
      final directDoc = await docRef.get();

      if (directDoc.exists) {
        final data = directDoc.data();
        if (data == null) {
          throw ServerException('User data is null for UID: $userUID');
        }
        return UserModel.fromJson({...data, 'id': directDoc.id});
      }

      // Fallback: query by userUID field (for users with auto-generated doc IDs)
      final query = await _firestore
          .collection(FirebaseCollections.users)
          .where('userUID', isEqualTo: userUID)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        throw ServerException('User not found with UID: $userUID');
      }

      final doc = query.docs.first;
      final data = doc.data();
      if (data == null) {
        throw ServerException('User data is null for UID: $userUID');
      }

      return UserModel.fromJson({...data, 'id': doc.id});
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to get user by UID: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> createUser(UserModel user) async {
    try {
      final docRef = _firestore.collection(FirebaseCollections.users).doc();
      final userWithId = UserModel(
        id: docRef.id,
        userName: user.userName,
        userBio: user.userBio,
        userBioLink: user.userBioLink,
        userUID: user.userUID,
        userEmail: user.userEmail,
      );

      await docRef.set(userWithId.toJson());
      return userWithId;
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to create user: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> createUserWithId(String docId, UserModel user) async {
    try {
      final docRef =
          _firestore.collection(FirebaseCollections.users).doc(docId);
      final userWithId = UserModel(
        id: docId,
        userName: user.userName,
        userBio: user.userBio,
        userBioLink: user.userBioLink,
        userUID: user.userUID,
        userEmail: user.userEmail,
      );

      await docRef.set(userWithId.toJson());
      return userWithId;
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to create user: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    try {
      if (user.id == null) {
        throw ServerException('Cannot update user without ID');
      }

      await _firestore
          .collection(FirebaseCollections.users)
          .doc(user.id)
          .update(user.toJson());

      return user;
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to update user: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore
          .collection(FirebaseCollections.users)
          .doc(userId)
          .delete();
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to delete user: ${e.toString()}');
    }
  }
}
