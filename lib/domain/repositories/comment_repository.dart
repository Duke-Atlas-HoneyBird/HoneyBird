import 'package:dartz/dartz.dart';
import '../entities/comment.dart';
import '../../core/error/failures.dart';

abstract class CommentRepository {
  Future<Either<Failure, List<Comment>>> getCommentsForPost(String postId);
  Future<Either<Failure, int>> getCommentCountForPost(String postId);
  Future<Either<Failure, Comment>> createComment(Comment comment);
}
