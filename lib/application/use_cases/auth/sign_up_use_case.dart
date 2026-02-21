import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/auth_user.dart';
import '../../../domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _authRepository;

  SignUpUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<Either<Failure, AuthUser>> call({
    required String email,
    required String password,
    String? displayName,
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

    if (password.length < 6) {
      return const Left(ValidationFailure('Password must be at least 6 characters'));
    }

    return await _authRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
      displayName: displayName,
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}