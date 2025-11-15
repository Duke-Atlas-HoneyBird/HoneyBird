import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/user_preference.dart';
import '../../../domain/repositories/user_preference_repository.dart';

class SavePreferences {
  final UserPreferenceRepository repository;

  SavePreferences(this.repository);

  Future<Either<Failure, void>> call(UserPreference preferences) {
    return repository.savePreferences(preferences);
  }
}
