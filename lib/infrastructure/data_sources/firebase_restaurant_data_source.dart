import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/constants.dart';
import '../models/restaurant_model.dart';

abstract class FirebaseRestaurantDataSource {
  Future<List<RestaurantModel>> getRestaurants();
  Future<RestaurantModel?> getRestaurant(String restaurantId);
}

class FirebaseRestaurantDataSourceImpl implements FirebaseRestaurantDataSource {
  final FirebaseFirestore firestore;

  FirebaseRestaurantDataSourceImpl({required this.firestore});

  CollectionReference get _restaurants =>
      firestore.collection(FirebaseCollections.restaurants);

  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    try {
      final snapshot = await _restaurants.orderBy('name').get();
      return snapshot.docs.map((doc) {
        final data =
            Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
        data['id'] = doc.id;
        return RestaurantModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw ServerException('Failed to get restaurants from Firestore: $e');
    }
  }

  @override
  Future<RestaurantModel?> getRestaurant(String restaurantId) async {
    try {
      final doc = await _restaurants.doc(restaurantId).get();
      if (!doc.exists) return null;
      final data = Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
      data['id'] = doc.id;
      return RestaurantModel.fromJson(data);
    } catch (e) {
      throw ServerException('Failed to get restaurant: $e');
    }
  }
}
