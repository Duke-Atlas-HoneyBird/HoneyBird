import 'package:cloud_firestore/cloud_firestore.dart';
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

  FirebaseFavoriteDataSourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<PostModel>> getFavoritePosts(String userUID) async {
    try {
      // Get favorite post IDs
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

      // Fetch the actual posts
      // Note: Firestore 'whereIn' is limited to 10-30 items depending on version/config
      // For a real app, you might want to fetch them individually or use a different structure
      final postsSnapshot = await _firestore
          .collection(FirebaseCollections.posts)
          .where(FieldPath.documentId, whereIn: favoriteIds)
          .get();

      return postsSnapshot.docs
          .map((doc) => PostModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to get favorites: $e');
    }
  }

  @override
  Future<void> addToFavorites(String postId, String userUID) async {
    try {
      await _firestore
          .collection(FirebaseCollections.favorites)
          .doc(userUID)
          .set({
        'postIds': FieldValue.arrayUnion([postId])
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to add favorite: $e');
    }
  }

  @override
  Future<void> removeFromFavorites(String postId, String userUID) async {
    try {
      await _firestore
          .collection(FirebaseCollections.favorites)
          .doc(userUID)
          .update({
        'postIds': FieldValue.arrayRemove([postId])
      });
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to remove favorite: $e');
    }
  }

  @override
  Future<bool> isFavorited(String postId, String userUID) async {
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
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to check favorite: $e');
    }
  }
}
