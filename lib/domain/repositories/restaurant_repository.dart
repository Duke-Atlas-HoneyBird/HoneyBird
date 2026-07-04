import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/restaurant.dart';

/// Repository interface for restaurant / merchant entities.
abstract class RestaurantRepository {
  /// List restaurants available for B2C contact.
  Future<Either<Failure, List<Restaurant>>> getRestaurants();

  /// Look up a single restaurant by ID.
  Future<Either<Failure, Restaurant?>> getRestaurant(String restaurantId);
}
