import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user_preference.dart';
import '../../domain/repositories/user_preference_repository.dart';
import '../data_sources/firebase_preference_data_source.dart';
import '../models/user_preference_model.dart';

/// Implementation of UserPreferenceRepository that uses Firestore as the data source
class UserPreferenceRepositoryImpl implements UserPreferenceRepository {
  final FirebasePreferenceDataSource dataSource;

  UserPreferenceRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, UserPreference>> getPreferences(String userId) async {
    try {
      final preferenceModel = await dataSource.getPreferences(userId);
      return Right(preferenceModel);
    } on ServerException catch (e) {
      print('[UserPreferenceRepositoryImpl] getPreferences ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[UserPreferenceRepositoryImpl] getPreferences unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> savePreferences(UserPreference preferences) async {
    try {
      final preferenceModel = UserPreferenceModel.fromEntity(preferences);
      await dataSource.savePreferences(preferenceModel);
      return const Right(null);
    } on ServerException catch (e) {
      print('[UserPreferenceRepositoryImpl] savePreferences ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[UserPreferenceRepositoryImpl] savePreferences unexpected: ${e.toString()}');
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }
}
