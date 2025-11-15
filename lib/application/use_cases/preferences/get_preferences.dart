import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/user_preference.dart';
import '../../../domain/repositories/user_preference_repository.dart';

class GetPreferences {
  final UserPreferenceRepository repository;

  GetPreferences(this.repository);

  Future<Either<Failure, UserPreference>> call(String userId) {
    return repository.getPreferences(userId);
  }
}
