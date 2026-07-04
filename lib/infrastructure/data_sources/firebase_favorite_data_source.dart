import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/constants.dart';
import '../models/post_model.dart';

abstract class FirebaseFavoriteDataSource {
  Future<List<PostModel>> getFavoritePosts(String userUID);
  Future<void> addToFavorites(String postId, String userUID);
  Future<void> removeFromFavorites(String postId, String userUID);
  Future<bool> isFavorited(String postId, String userUID);
}

class FirebaseFavoriteDataSourceImpl implements FirebaseFavoriteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FirebaseFavoriteDataSourceImpl({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  void _assertOwnFavorites(String userUID) {
    if (userUID.isEmpty) {
      throw ServerException('User ID is required to access favorites');
    }
    final currentUid = _auth.currentUser?.uid;
    if (currentUid == null || currentUid != userUID) {
      throw ServerException('Not authorized to access favorites for this user');
    }
  }

  @override
  Future<List<PostModel>> getFavoritePosts(String userUID) async {
    _assertOwnFavorites(userUID);

    try {
      final snapshot = await _firestore
          .collection(FirebaseCollections.favorites)
          .doc(userUID)
          .get();

      if (!snapshot.exists) {
        return [];
      }

      final favoriteIds = List<String>.from(snapshot.data()?['postIds'] ?? []);
      if (favoriteIds.isEmpty) {
        return [];
      }

      final postsSnapshot = await _firestore
          .collection(FirebaseCollections.posts)
          .where(FieldPath.documentId, whereIn: favoriteIds)
          .get();

      final postsById = {
        for (final doc in postsSnapshot.docs)
          doc.id: PostModel.fromJson({...doc.data(), 'id': doc.id}),
      };

      // Preserve the user's favorite order; omit deleted posts.
      return favoriteIds
          .map((id) => postsById[id])
          .whereType<PostModel>()
          .toList();
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to get favorites: $e');
    }
  }

  @override
  Future<void> addToFavorites(String postId, String userUID) async {
    _assertOwnFavorites(userUID);

    try {
      await _firestore
          .collection(FirebaseCollections.favorites)
          .doc(userUID)
          .set({
        'postIds': FieldValue.arrayUnion([postId])
      }, SetOptions(merge: true));
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to add favorite: $e');
    }
  }

  @override
  Future<void> removeFromFavorites(String postId, String userUID) async {
    _assertOwnFavorites(userUID);

    try {
      await _firestore
          .collection(FirebaseCollections.favorites)
          .doc(userUID)
          .update({
        'postIds': FieldValue.arrayRemove([postId])
      });
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to remove favorite: $e');
    }
  }

  @override
  Future<bool> isFavorited(String postId, String userUID) async {
    _assertOwnFavorites(userUID);

    try {
      final snapshot = await _firestore
          .collection(FirebaseCollections.favorites)
          .doc(userUID)
          .get();

      if (!snapshot.exists) {
        return false;
      }

      final favoriteIds = List<String>.from(snapshot.data()?['postIds'] ?? []);
      return favoriteIds.contains(postId);
    } on ServerException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to check favorite: $e');
    }
  }
}
