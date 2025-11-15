import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/repositories/post_repository.dart';

class GetPost {
  final PostRepository repository;

  GetPost(this.repository);

  Future<Either<Failure, Post>> call(String postId) {
    return repository.getPost(postId);
  }
}
