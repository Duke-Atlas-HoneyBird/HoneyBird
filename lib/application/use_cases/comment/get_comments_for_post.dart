import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/comment.dart';
import '../../../domain/repositories/comment_repository.dart';

class GetCommentsForPost {
  final CommentRepository repository;

  GetCommentsForPost(this.repository);

  Future<Either<Failure, List<Comment>>> call(String postId) {
    return repository.getCommentsForPost(postId);
  }
}
