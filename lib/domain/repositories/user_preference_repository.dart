import 'package:dartz/dartz.dart';
import '../entities/user_preference.dart';
import '../../core/error/failures.dart';

abstract class UserPreferenceRepository {
  Future<Either<Failure, UserPreference>> getPreferences(String userId);
  Future<Either<Failure, void>> savePreferences(UserPreference preferences);
}
