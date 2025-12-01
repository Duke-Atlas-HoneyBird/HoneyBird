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
      final now = DateTime.now();
    final postModels = [
          Post(
        id: 'feed_1',
        text: 'Just discovered an amazing new restaurant in Cape Town! The food was incredible and the atmosphere was perfect for a date night. Highly recommend trying their signature dish!',
        publishedDate: now.subtract(const Duration(hours: 2)),
        userName: 'FoodieExplorer',
        userUID: 'user_feed_1',
        upvoteIDs: const ['user1', 'user2', 'user3', 'user4'],
        downvoteIDs: const [],
      ),
      Post(
        id: 'feed_2',
        text: 'Wine tasting at a local vineyard was absolutely breathtaking. The sunset views paired with excellent wines made for an unforgettable experience. Perfect for wine lovers!',
        publishedDate: now.subtract(const Duration(hours: 5)),
        userName: 'WineEnthusiast',
        userUID: 'user_feed_2',
        upvoteIDs: const ['user1', 'user2', 'user3', 'user4', 'user5', 'user6'],
        downvoteIDs: const ['user7'],
      ),
      Post(
        id: 'feed_3',
        text: 'Outdoor adventure at Table Mountain today! The hike was challenging but the views from the top were absolutely worth it. Nature never fails to amaze me.',
        publishedDate: now.subtract(const Duration(days: 1)),
        userName: 'AdventureSeeker',
        userUID: 'user_feed_3',
        upvoteIDs: const ['user1', 'user2', 'user3'],
        downvoteIDs: const [],
      ),
      Post(
        id: 'feed_4',
        text: 'Tried authentic Italian cuisine at a hidden gem in the city. The pasta was handmade and the flavors were incredible. A must-visit for Italian food lovers!',
        publishedDate: now.subtract(const Duration(days: 1, hours: 3)),
        userName: 'ItalianFoodLover',
        userUID: 'user_feed_4',
        upvoteIDs: const ['user1', 'user2', 'user3', 'user4', 'user5'],
        downvoteIDs: const ['user6'],
      ),
      Post(
        id: 'feed_5',
        text: 'Greek restaurant with amazing Mediterranean flavors! The moussaka was perfect and the atmosphere reminded me of my trip to Greece. Highly recommend!',
        publishedDate: now.subtract(const Duration(days: 2)),
        userName: 'MediterraneanFan',
        userUID: 'user_feed_5',
        upvoteIDs: const ['user1', 'user2'],
        downvoteIDs: const [],
      ),
      Post(
        id: 'feed_6',
        text: 'Chinese dim sum experience was outstanding! The variety of dumplings and the authentic flavors made this one of my best dining experiences this year.',
        publishedDate: now.subtract(const Duration(days: 2, hours: 5)),
        userName: 'DimSumLover',
        userUID: 'user_feed_6',
        upvoteIDs: const ['user1', 'user2', 'user3', 'user4'],
        downvoteIDs: const ['user5'],
      ),
      Post(
        id: 'feed_7',
        text: 'Thai street food market visit was incredible! The pad thai and green curry were authentic and delicious. Great place to explore different flavors!',
        publishedDate: now.subtract(const Duration(days: 3)),
        userName: 'ThaiFoodExplorer',
        userUID: 'user_feed_7',
        upvoteIDs: const ['user1', 'user2', 'user3'],
        downvoteIDs: const [],
      ),
      Post(
        id: 'feed_8',
        text: 'African cuisine restaurant with traditional dishes was a cultural experience! The flavors were rich and authentic. Loved learning about the different regional cuisines.',
        publishedDate: now.subtract(const Duration(days: 4)),
        userName: 'CulturalFoodie',
        userUID: 'user_feed_8',
        upvoteIDs: const ['user1', 'user2', 'user3', 'user4', 'user5', 'user6', 'user7'],
        downvoteIDs: const [],
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
