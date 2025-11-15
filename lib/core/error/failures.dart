import 'package:equatable/equatable.dart';

/// Abstract base class for all failures in the domain layer
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Failure representing server-side errors (Firebase, API, etc.)
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Failure representing local cache/storage errors
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Failure representing validation errors
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Failure representing network connectivity errors
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}
