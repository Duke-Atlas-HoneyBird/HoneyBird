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
    return _getPreferencesWithRetry(userId, retryCount: 0);
  }

  Future<UserPreferenceModel> _getPreferencesWithRetry(String userId, {required int retryCount}) async {
    try {
      final docRef = _collection.doc(userId);
      final doc = await docRef.get();

      if (!doc.exists) {
        // Create default preferences for new users
        final defaultPrefs = UserPreferenceModel(id: userId);
        await docRef.set(defaultPrefs.toJson());
        return defaultPrefs;
      }

      return UserPreferenceModel.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      if (e is ServerException) rethrow;
      final errStr = e.toString();
      if (errStr.contains('permission-denied') && retryCount < 1) {
        await Future<void>.delayed(const Duration(milliseconds: 1500));
        return _getPreferencesWithRetry(userId, retryCount: retryCount + 1);
      }
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
