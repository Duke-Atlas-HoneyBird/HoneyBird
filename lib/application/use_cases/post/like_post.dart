import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/repositories/post_repository.dart';

/// Toggles star (like) on a post for the given user.
class LikePost {
  final PostRepository repository;

  LikePost(this.repository);

  Future<Either<Failure, Post>> call(String postId, String userId) {
    return repository.likePost(postId, userId);
  }
}
