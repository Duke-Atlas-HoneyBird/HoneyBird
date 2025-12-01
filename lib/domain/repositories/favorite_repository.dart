import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/post.dart';

/// Repository interface for favorite posts operations
abstract class FavoriteRepository {
  /// Get all favorite posts for a user
  Future<Either<Failure, List<Post>>> getFavoritePosts(String userUID);

  /// Add a post to favorites
  Future<Either<Failure, void>> addToFavorites(String postId, String userUID);

  /// Remove a post from favorites
  Future<Either<Failure, void>> removeFromFavorites(String postId, String userUID);

  /// Check if a post is favorited by user
  Future<Either<Failure, bool>> isFavorited(String postId, String userUID);
}

