import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/favorite_repository.dart';

/// Implementation of FavoriteRepository with dummy data
class FavoriteRepositoryImpl implements FavoriteRepository {
  // In-memory storage for favorites (dummy data)
  final Map<String, List<String>> _userFavorites = {
    'current_user': ['post_1', 'post_3', 'post_5'],
  };

  // Dummy posts for favorites
  List<Post> _generateFavoritePosts(List<String> favoriteIds) {
    final now = DateTime.now();
    final allPosts = [
      Post(
        id: 'post_1',
        text: 'Amazing wine tasting experience at a local vineyard! The sunset views were breathtaking and the wines were exceptional. Highly recommend this place!',
        publishedDate: now.subtract(const Duration(days: 3)),
        userName: 'WineEnthusiast',
        userUID: 'user_wine',
        upvoteIDs: const ['user1', 'user2', 'user3', 'user4', 'user5'],
        downvoteIDs: const [],
      ),
      Post(
        id: 'post_3',
        text: 'Outdoor adventure at Table Mountain was incredible! The hike was challenging but the views from the top made it all worth it. Nature never fails to amaze.',
        publishedDate: now.subtract(const Duration(days: 5)),
        userName: 'AdventureSeeker',
        userUID: 'user_adventure',
        upvoteIDs: const ['user1', 'user2', 'user3'],
        downvoteIDs: const [],
      ),
      Post(
        id: 'post_5',
        text: 'Authentic Italian cuisine at a hidden gem in the city. The pasta was handmade and the flavors were incredible. A must-visit for Italian food lovers!',
        publishedDate: now.subtract(const Duration(days: 7)),
        userName: 'ItalianFoodLover',
        userUID: 'user_italian',
        upvoteIDs: const ['user1', 'user2', 'user3', 'user4', 'user5', 'user6'],
        downvoteIDs: const [],
      ),
    ];

    return allPosts.where((post) => favoriteIds.contains(post.id)).toList();
  }

  @override
  Future<Either<Failure, List<Post>>> getFavoritePosts(String userUID) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    final favoriteIds = _userFavorites[userUID] ?? [];
    final favoritePosts = _generateFavoritePosts(favoriteIds);
    
    return Right(favoritePosts);
  }

  @override
  Future<Either<Failure, void>> addToFavorites(String postId, String userUID) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (!_userFavorites.containsKey(userUID)) {
      _userFavorites[userUID] = [];
    }
    
    if (!_userFavorites[userUID]!.contains(postId)) {
      _userFavorites[userUID]!.add(postId);
    }
    
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(String postId, String userUID) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    _userFavorites[userUID]?.remove(postId);
    
    return const Right(null);
  }

  @override
  Future<Either<Failure, bool>> isFavorited(String postId, String userUID) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));
    
    final favoriteIds = _userFavorites[userUID] ?? [];
    return Right(favoriteIds.contains(postId));
  }
}

