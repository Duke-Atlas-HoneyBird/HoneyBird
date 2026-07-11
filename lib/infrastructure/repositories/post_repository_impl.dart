import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../data_sources/firebase_post_data_source.dart';
import '../models/post_model.dart';

/// Implementation of PostRepository that uses Firebase as the data source
class PostRepositoryImpl implements PostRepository {
  final FirebasePostDataSource _firebaseDataSource;

  PostRepositoryImpl({required FirebasePostDataSource firebaseDataSource})
      : _firebaseDataSource = firebaseDataSource;

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final postModels = await _firebaseDataSource.getPosts();
      return Right(postModels.map((model) => model.toDomain()).toList());
    } on ServerException catch (e) {
      print('[PostRepositoryImpl] getPosts ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[PostRepositoryImpl] getPosts unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getPostsByUserUID(String userUID) async {
    try {
      final postModels = await _firebaseDataSource.getPostsByUserUID(userUID);
      return Right(postModels.map((model) => model.toDomain()).toList());
    } on ServerException catch (e) {
      print(
          '[PostRepositoryImpl] getPostsByUserUID ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print(
          '[PostRepositoryImpl] getPostsByUserUID unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Post>> getPost(String postId) async {
    try {
      final postModel = await _firebaseDataSource.getPost(postId);
      return Right(postModel.toDomain());
    } on ServerException catch (e) {
      print('[PostRepositoryImpl] getPost ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[PostRepositoryImpl] getPost unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Post>> createPost(Post post) async {
    try {
      final postModel = PostModel.fromEntity(post);
      final createdPost = await _firebaseDataSource.createPost(postModel);
      return Right(createdPost.toDomain());
    } on ServerException catch (e) {
      print('[PostRepositoryImpl] createPost ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[PostRepositoryImpl] createPost unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Post>> updatePost(Post post) async {
    try {
      final postModel = PostModel.fromEntity(post);
      final updatedPost = await _firebaseDataSource.updatePost(postModel);
      return Right(updatedPost.toDomain());
    } on ServerException catch (e) {
      print('[PostRepositoryImpl] updatePost ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[PostRepositoryImpl] updatePost unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String postId) async {
    try {
      await _firebaseDataSource.deletePost(postId);
      return const Right(null);
    } on ServerException catch (e) {
      print('[PostRepositoryImpl] deletePost ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[PostRepositoryImpl] deletePost unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Post>> likePost(String postId, String userId) async {
    try {
      final updatedPost = await _firebaseDataSource.likePost(postId, userId);
      return Right(updatedPost.toDomain());
    } on ServerException catch (e) {
      print('[PostRepositoryImpl] likePost ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[PostRepositoryImpl] likePost unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }
}
