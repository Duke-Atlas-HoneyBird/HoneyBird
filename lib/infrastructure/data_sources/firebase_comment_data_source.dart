import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/constants.dart';
import '../models/comment_model.dart';

/// Abstract interface for Firebase comment data operations (post subcollection).
abstract class FirebaseCommentDataSource {
  Future<List<CommentModel>> getCommentsForPost(String postId);
  Future<int> getCommentCountForPost(String postId);
  Future<CommentModel> createComment(CommentModel comment);
}

/// Implementation using Cloud Firestore subcollection: posts/{postId}/comments.
class FirebaseCommentDataSourceImpl implements FirebaseCommentDataSource {
  final FirebaseFirestore _firestore;

  FirebaseCommentDataSourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _commentsRef(String postId) {
    return _firestore
        .collection(FirebaseCollections.posts)
        .doc(postId)
        .collection(FirebaseCollections.comments);
  }

  @override
  Future<List<CommentModel>> getCommentsForPost(String postId) async {
    try {
      final querySnapshot = await _commentsRef(postId)
          .orderBy('publishedDate', descending: false)
          .get();

      return querySnapshot.docs
          .map((doc) =>
              CommentModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to get comments: $e');
    }
  }

  @override
  Future<int> getCommentCountForPost(String postId) async {
    try {
      final aggregateSnapshot =
          await _commentsRef(postId).count().get();
      return aggregateSnapshot.count ?? 0;
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to get comment count: $e');
    }
  }

  @override
  Future<CommentModel> createComment(CommentModel comment) async {
    try {
      final docRef = _commentsRef(comment.postId).doc();
      final commentWithId = CommentModel(
        id: docRef.id,
        postId: comment.postId,
        text: comment.text,
        publishedDate: comment.publishedDate,
        userName: comment.userName,
        userUID: comment.userUID,
      );

      await docRef.set(commentWithId.toJson());
      return commentWithId;
    } on FirebaseException catch (e) {
      throw ServerException('Firebase error: ${e.message ?? e.code}');
    } catch (e) {
      throw ServerException('Failed to create comment: $e');
    }
  }
}
