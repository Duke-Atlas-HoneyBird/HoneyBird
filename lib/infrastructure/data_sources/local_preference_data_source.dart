import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/constants.dart';
import '../models/user_preference_model.dart';

/// Abstract interface for local user preference data operations
abstract class LocalPreferenceDataSource {
  /// Retrieves user preferences from local storage
  Future<UserPreferenceModel> getPreferences(String userId);

  /// Saves user preferences to local storage
  Future<void> savePreferences(UserPreferenceModel preferences);
}

/// Implementation of LocalPreferenceDataSource using SharedPreferences
class LocalPreferenceDataSourceImpl implements LocalPreferenceDataSource {
  final SharedPreferences sharedPreferences;

  LocalPreferenceDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserPreferenceModel> getPreferences(String userId) async {
    try {
      final key = '${StorageKeys.userPreferences}_$userId';
      final jsonString = sharedPreferences.getString(key);

      if (jsonString == null) {
        throw CacheException('No preferences found for user: $userId');
      }

      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return UserPreferenceModel.fromJson(jsonMap);
    } catch (e) {
      if (e is CacheException) {
        rethrow;
      }
      throw CacheException('Failed to get preferences: $e');
    }
  }

  @override
  Future<void> savePreferences(UserPreferenceModel preferences) async {
    try {
      final key = '${StorageKeys.userPreferences}_${preferences.id}';
      final jsonString = json.encode(preferences.toJson());
      
      final success = await sharedPreferences.setString(key, jsonString);
      
      if (!success) {
        throw CacheException('Failed to save preferences to local storage');
      }
    } catch (e) {
      if (e is CacheException) {
        rethrow;
      }
      throw CacheException('Failed to save preferences: $e');
    }
  }
}
