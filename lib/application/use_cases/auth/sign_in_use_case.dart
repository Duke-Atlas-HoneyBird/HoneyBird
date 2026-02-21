import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/auth_user.dart';
import '../../../domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _authRepository;

  SignInUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<Either<Failure, AuthUser>> call({
    required String email,
    required String password,
  }) async {
    // Basic validation
    if (email.isEmpty) {
      return const Left(ValidationFailure('Email cannot be empty'));
    }
    
    if (password.isEmpty) {
      return const Left(ValidationFailure('Password cannot be empty'));
    }

    if (!_isValidEmail(email)) {
      return const Left(ValidationFailure('Invalid email format'));
    }

    return await _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}