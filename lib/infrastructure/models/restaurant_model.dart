import '../../domain/entities/restaurant.dart';

class RestaurantModel extends Restaurant {
  RestaurantModel({
    super.id,
    required super.name,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] as String?,
      name: json['name'] as String? ?? 'Restaurant',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory RestaurantModel.fromEntity(Restaurant restaurant) {
    return RestaurantModel(
      id: restaurant.id,
      name: restaurant.name,
    );
  }
}
