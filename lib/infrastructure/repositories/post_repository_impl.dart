import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../data_sources/firebase_post_data_source.dart';
import '../models/post_model.dart';

/// Implementation of PostRepository that uses Firebase as the data source
class PostRepositoryImpl implements PostRepository {
  final FirebasePostDataSource dataSource;

  PostRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      // final postModels = await dataSource.getPosts();
      final postModels = [
        Post(
          id: '1',
          text: 'Hello, world!',
          publishedDate: DateTime.now(),
          userName: 'John Doe',
          userUID: '123',
        ),
        Post(
          id: '2',
          text: 'Hello, world!',
          publishedDate: DateTime.now(),
          userName: 'John Doe',
          userUID: '123',
        ),
        Post(
          id: '3',
          text: 'Hello, world!',
          publishedDate: DateTime.now(),
          userName: 'John Doe',
          userUID: '123',
        ),
      ];
      return Right(postModels);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Post>> getPost(String postId) async {
    try {
      final postModel = await dataSource.getPost(postId);
      return Right(postModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Post>> createPost(Post post) async {
    try {
      final postModel = PostModel.fromEntity(post);
      final createdPost = await dataSource.createPost(postModel);
      return Right(createdPost);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Post>> updatePost(Post post) async {
    try {
      final postModel = PostModel.fromEntity(post);
      final updatedPost = await dataSource.updatePost(postModel);
      return Right(updatedPost);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String postId) async {
    try {
      await dataSource.deletePost(postId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Post>> upvotePost(String postId, String userId) async {
    try {
      final updatedPost = await dataSource.upvotePost(postId, userId);
      return Right(updatedPost);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Post>> downvotePost(String postId, String userId) async {
    try {
      final updatedPost = await dataSource.downvotePost(postId, userId);
      return Right(updatedPost);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }
}
