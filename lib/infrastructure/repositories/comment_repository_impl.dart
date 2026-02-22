import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/comment.dart';
import '../../domain/repositories/comment_repository.dart';
import '../data_sources/firebase_comment_data_source.dart';
import '../models/comment_model.dart';

/// Implementation of CommentRepository using Firebase comments subcollection.
class CommentRepositoryImpl implements CommentRepository {
  final FirebaseCommentDataSource _dataSource;

  CommentRepositoryImpl({required FirebaseCommentDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Either<Failure, List<Comment>>> getCommentsForPost(String postId) async {
    try {
      final models = await _dataSource.getCommentsForPost(postId);
      return Right(models.map((m) => m.toDomain()).toList());
    } on ServerException catch (e) {
      print('[CommentRepositoryImpl] getCommentsForPost ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[CommentRepositoryImpl] getCommentsForPost unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, int>> getCommentCountForPost(String postId) async {
    try {
      final count = await _dataSource.getCommentCountForPost(postId);
      return Right(count);
    } on ServerException catch (e) {
      print('[CommentRepositoryImpl] getCommentCountForPost ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[CommentRepositoryImpl] getCommentCountForPost unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Comment>> createComment(Comment comment) async {
    try {
      final model = CommentModel.fromEntity(comment);
      final created = await _dataSource.createComment(model);
      return Right(created.toDomain());
    } on ServerException catch (e) {
      print('[CommentRepositoryImpl] createComment ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[CommentRepositoryImpl] createComment unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }
}
