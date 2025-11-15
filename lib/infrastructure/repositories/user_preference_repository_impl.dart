import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user_preference.dart';
import '../../domain/repositories/user_preference_repository.dart';
import '../data_sources/local_preference_data_source.dart';
import '../models/user_preference_model.dart';

/// Implementation of UserPreferenceRepository that uses local storage as the data source
class UserPreferenceRepositoryImpl implements UserPreferenceRepository {
  final LocalPreferenceDataSource dataSource;

  UserPreferenceRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, UserPreference>> getPreferences(String userId) async {
    try {
      final preferenceModel = await dataSource.getPreferences(userId);
      return Right(preferenceModel);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> savePreferences(UserPreference preferences) async {
    try {
      final preferenceModel = UserPreferenceModel.fromEntity(preferences);
      await dataSource.savePreferences(preferenceModel);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error occurred: $e'));
    }
  }
}
