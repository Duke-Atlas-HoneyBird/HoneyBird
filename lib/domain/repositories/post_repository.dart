import 'package:dartz/dartz.dart';
import '../entities/post.dart';
import '../../core/error/failures.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, List<Post>>> getPostsByUserUID(String userUID);
  Future<Either<Failure, Post>> getPost(String postId);
  Future<Either<Failure, Post>> createPost(Post post);
  Future<Either<Failure, Post>> updatePost(Post post);
  Future<Either<Failure, void>> deletePost(String postId);
  /// Toggle star (like) for a post.
  Future<Either<Failure, Post>> likePost(String postId, String userId);
}
