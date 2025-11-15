import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/constants.dart';
import '../models/post_model.dart';

/// Abstract interface for Firebase post data operations
abstract class FirebasePostDataSource {
  /// Retrieves all posts from Firestore
  Future<List<PostModel>> getPosts();

  /// Retrieves a single post from Firestore by post ID
  Future<PostModel> getPost(String postId);

  /// Creates a new post in Firestore
  Future<PostModel> createPost(PostModel post);

  /// Updates an existing post in Firestore
  Future<PostModel> updatePost(PostModel post);

  /// Deletes a post from Firestore
  Future<void> deletePost(String postId);

  /// Adds a user ID to the upvote list of a post
  Future<PostModel> upvotePost(String postId, String userId);

  /// Adds a user ID to the downvote list of a post
  Future<PostModel> downvotePost(String postId, String userId);
}

/// Implementation of FirebasePostDataSource using Cloud Firestore
class FirebasePostDataSourceImpl implements FirebasePostDataSource {
  final FirebaseFirestore firestore;

  FirebasePostDataSourceImpl({required this.firestore});

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final querySnapshot = await firestore
          .collection(FirebaseCollections.posts)
          .orderBy('publishedDate', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => PostModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to get posts: $e');
    }
  }

  @override
  Future<PostModel> getPost(String postId) async {
    try {
      final doc = await firestore
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

      return PostModel.fromJson(data);
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to get post: $e');
    }
  }

  @override
  Future<PostModel> createPost(PostModel post) async {
    try {
      final docRef = firestore.collection(FirebaseCollections.posts).doc();
      final postWithId = PostModel(
        id: docRef.id,
        text: post.text,
        imageURL: post.imageURL,
        imageReferenceID: post.imageReferenceID,
        publishedDate: post.publishedDate,
        upvoteIDs: post.upvoteIDs,
        downvoteIDs: post.downvoteIDs,
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

      await firestore
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
      await firestore
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
  Future<PostModel> upvotePost(String postId, String userId) async {
    try {
      final docRef = firestore
          .collection(FirebaseCollections.posts)
          .doc(postId);

      await firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);

        if (!snapshot.exists) {
          throw ServerException('Post not found with ID: $postId');
        }

        final data = snapshot.data();
        if (data == null) {
          throw ServerException('Post data is null for ID: $postId');
        }

        final upvoteIDs = List<String>.from(data['upvoteIDs'] as List? ?? []);
        final downvoteIDs = List<String>.from(data['downvoteIDs'] as List? ?? []);

        // Remove from downvotes if present
        downvoteIDs.remove(userId);

        // Add to upvotes if not already present
        if (!upvoteIDs.contains(userId)) {
          upvoteIDs.add(userId);
        }

        transaction.update(docRef, {
          'upvoteIDs': upvoteIDs,
          'downvoteIDs': downvoteIDs,
        });
      });

      // Fetch and return the updated post
      return await getPost(postId);
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to upvote post: $e');
    }
  }

  @override
  Future<PostModel> downvotePost(String postId, String userId) async {
    try {
      final docRef = firestore
          .collection(FirebaseCollections.posts)
          .doc(postId);

      await firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);

        if (!snapshot.exists) {
          throw ServerException('Post not found with ID: $postId');
        }

        final data = snapshot.data();
        if (data == null) {
          throw ServerException('Post data is null for ID: $postId');
        }

        final upvoteIDs = List<String>.from(data['upvoteIDs'] as List? ?? []);
        final downvoteIDs = List<String>.from(data['downvoteIDs'] as List? ?? []);

        // Remove from upvotes if present
        upvoteIDs.remove(userId);

        // Add to downvotes if not already present
        if (!downvoteIDs.contains(userId)) {
          downvoteIDs.add(userId);
        }

        transaction.update(docRef, {
          'upvoteIDs': upvoteIDs,
          'downvoteIDs': downvoteIDs,
        });
      });

      // Fetch and return the updated post
      return await getPost(postId);
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to downvote post: $e');
    }
  }
}
