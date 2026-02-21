import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../domain/repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository _authRepository;

  SignOutUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<Either<Failure, void>> call() async {
    return await _authRepository.signOut();
  }
}