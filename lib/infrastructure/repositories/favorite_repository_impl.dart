import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../data_sources/firebase_favorite_data_source.dart';

/// Implementation of FavoriteRepository that uses Firebase as the data source
class FavoriteRepositoryImpl implements FavoriteRepository {
  final FirebaseFavoriteDataSource _firebaseDataSource;

  FavoriteRepositoryImpl({required FirebaseFavoriteDataSource firebaseDataSource})
      : _firebaseDataSource = firebaseDataSource;

  @override
  Future<Either<Failure, List<Post>>> getFavoritePosts(String userUID) async {
    try {
      final postModels = await _firebaseDataSource.getFavoritePosts(userUID);
      return Right(postModels.map((model) => model.toDomain()).toList());
    } on ServerException catch (e) {
      print('[FavoriteRepositoryImpl] getFavoritePosts ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[FavoriteRepositoryImpl] getFavoritePosts unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> addToFavorites(String postId, String userUID) async {
    try {
      await _firebaseDataSource.addToFavorites(postId, userUID);
      return const Right(null);
    } on ServerException catch (e) {
      print('[FavoriteRepositoryImpl] addToFavorites ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[FavoriteRepositoryImpl] addToFavorites unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(String postId, String userUID) async {
    try {
      await _firebaseDataSource.removeFromFavorites(postId, userUID);
      return const Right(null);
    } on ServerException catch (e) {
      print('[FavoriteRepositoryImpl] removeFromFavorites ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[FavoriteRepositoryImpl] removeFromFavorites unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorited(String postId, String userUID) async {
    try {
      final isFavorited = await _firebaseDataSource.isFavorited(postId, userUID);
      return Right(isFavorited);
    } on ServerException catch (e) {
      print('[FavoriteRepositoryImpl] isFavorited ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[FavoriteRepositoryImpl] isFavorited unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }
}

