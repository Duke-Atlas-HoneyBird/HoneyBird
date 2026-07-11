import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/constants.dart';
import '../models/post_model.dart';

/// Abstract interface for Firebase post data operations
abstract class FirebasePostDataSource {
  /// Retrieves all posts from Firestore
  Future<List<PostModel>> getPosts();

  /// Retrieves posts authored by [userUID], newest first.
  Future<List<PostModel>> getPostsByUserUID(String userUID);

  /// Retrieves a single post from Firestore by post ID
  Future<PostModel> getPost(String postId);

  /// Creates a new post in Firestore
  Future<PostModel> createPost(PostModel post);

  /// Updates an existing post in Firestore
  Future<PostModel> updatePost(PostModel post);

  /// Deletes a post from Firestore
  Future<void> deletePost(String postId);

  /// Toggles like (star) for a post: adds userId to likeIDs if not present, removes if present.
  Future<PostModel> likePost(String postId, String userId);
}

/// Implementation of FirebasePostDataSource using Cloud Firestore
class FirebasePostDataSourceImpl implements FirebasePostDataSource {
  final FirebaseFirestore _firestore;

  FirebasePostDataSourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final querySnapshot = await _firestore
          .collection(FirebaseCollections.posts)
          .orderBy('publishedDate', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => PostModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to get posts: $e');
    }
  }

  @override
  Future<List<PostModel>> getPostsByUserUID(String userUID) async {
    try {
      final querySnapshot = await _firestore
          .collection(FirebaseCollections.posts)
          .where('userUID', isEqualTo: userUID)
          .get();

      final posts = querySnapshot.docs
          .map((doc) => PostModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
      posts.sort((a, b) => b.publishedDate.compareTo(a.publishedDate));
      return posts;
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to get posts for user: $e');
    }
  }

  @override
  Future<PostModel> getPost(String postId) async {
    try {
      final doc = await _firestore
          .collection(FirebaseCollections.posts)
          .doc(postId)
          .get();

      if (!doc.exists) {
        throw ServerException('Post not found with ID: $postId');
      }

      final data = doc.data();
      if (data == null) {
        throw ServerException('Post data is null for ID: $postId');
      }

      return PostModel.fromJson({...data, 'id': doc.id});
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to get post: $e');
    }
  }

  @override
  Future<PostModel> createPost(PostModel post) async {
    try {
      final docRef = _firestore.collection(FirebaseCollections.posts).doc();
      final postWithId = PostModel(
        id: docRef.id,
        text: post.text,
        imageURL: post.imageURL,
        imageReferenceID: post.imageReferenceID,
        videoURL: post.videoURL,
        videoReferenceID: post.videoReferenceID,
        publishedDate: post.publishedDate,
        likeIDs: post.likeIDs,
        userName: post.userName,
        userUID: post.userUID,
      );

      await docRef.set(postWithId.toJson());
      return postWithId;
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to create post: $e');
    }
  }

  @override
  Future<PostModel> updatePost(PostModel post) async {
    try {
      if (post.id == null) {
        throw ServerException('Cannot update post without ID');
      }

      await _firestore
          .collection(FirebaseCollections.posts)
          .doc(post.id)
          .update(post.toJson());

      return post;
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to update post: $e');
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    try {
      await _firestore
          .collection(FirebaseCollections.posts)
          .doc(postId)
          .delete();
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to delete post: $e');
    }
  }

  @override
  Future<PostModel> likePost(String postId, String userId) async {
    try {
      final docRef = _firestore
          .collection(FirebaseCollections.posts)
          .doc(postId);

      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);

        if (!snapshot.exists) {
          throw ServerException('Post not found with ID: $postId');
        }

        final data = snapshot.data();
        if (data == null) {
          throw ServerException('Post data is null for ID: $postId');
        }

        var likeIDs = List<String>.from(data['likeIDs'] as List? ?? []);
        if (data['likeIDs'] == null && data['upvoteIDs'] != null) {
          likeIDs = List<String>.from(data['upvoteIDs'] as List? ?? []);
        }
        if (likeIDs.contains(userId)) {
          likeIDs.remove(userId);
        } else {
          likeIDs.add(userId);
        }

        transaction.update(docRef, {'likeIDs': likeIDs});
      });

      return await getPost(postId);
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to like post: $e');
    }
  }
}
