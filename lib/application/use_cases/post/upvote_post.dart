import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/repositories/post_repository.dart';

class UpvotePost {
  final PostRepository repository;

  UpvotePost(this.repository);

  Future<Either<Failure, Post>> call(String postId, String userId) {
    return repository.upvotePost(postId, userId);
  }
}
