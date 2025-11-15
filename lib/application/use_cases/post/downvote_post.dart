import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/repositories/post_repository.dart';

class DownvotePost {
  final PostRepository repository;

  DownvotePost(this.repository);

  Future<Either<Failure, Post>> call(String postId, String userId) {
    return repository.downvotePost(postId, userId);
  }
}
