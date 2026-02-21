import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/constants.dart';
import '../models/user_preference_model.dart';

/// Abstract interface for Firebase user preference data operations
abstract class FirebasePreferenceDataSource {
  /// Retrieves user preferences from Firestore
  Future<UserPreferenceModel> getPreferences(String userId);

  /// Saves user preferences to Firestore
  Future<void> savePreferences(UserPreferenceModel preferences);
}

/// Implementation of FirebasePreferenceDataSource using Cloud Firestore
class FirebasePreferenceDataSourceImpl implements FirebasePreferenceDataSource {
  final FirebaseFirestore firestore;

  FirebasePreferenceDataSourceImpl({required this.firestore});

  CollectionReference get _collection => firestore.collection(FirebaseCollections.preferences);

  @override
  Future<UserPreferenceModel> getPreferences(String userId) async {
    try {
      final doc = await _collection.doc(userId).get();

      if (!doc.exists) {
        throw ServerException('No preferences found for user: $userId');
      }

      return UserPreferenceModel.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Failed to get preferences from Firestore: $e');
    }
  }

  @override
  Future<void> savePreferences(UserPreferenceModel preferences) async {
    try {
      await _collection.doc(preferences.id).set(preferences.toJson());
    } catch (e) {
      throw ServerException('Failed to save preferences to Firestore: $e');
    }
  }
}
