import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/comment.dart';
import '../../../domain/repositories/comment_repository.dart';

class CreateComment {
  final CommentRepository repository;

  CreateComment(this.repository);

  Future<Either<Failure, Comment>> call(Comment comment) {
    return repository.createComment(comment);
  }
}
