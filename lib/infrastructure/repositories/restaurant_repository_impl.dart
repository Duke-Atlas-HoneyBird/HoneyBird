import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../data_sources/firebase_restaurant_data_source.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final FirebaseRestaurantDataSource dataSource;

  RestaurantRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurants() async {
    try {
      final restaurants = await dataSource.getRestaurants();
      return Right(restaurants);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Restaurant?>> getRestaurant(String restaurantId) async {
    try {
      final restaurant = await dataSource.getRestaurant(restaurantId);
      return Right(restaurant);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }
}
