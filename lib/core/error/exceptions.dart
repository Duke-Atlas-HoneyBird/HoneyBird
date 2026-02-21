/// Base class for all exceptions in the infrastructure layer
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

/// Exception thrown when server operations fail
class ServerException extends AppException {
  const ServerException(super.message);
}

/// Exception thrown when cache operations fail
class CacheException extends AppException {
  const CacheException(super.message);
}

/// Exception thrown when network operations fail
class NetworkException extends AppException {
  const NetworkException(super.message);
}

/// Exception thrown when validation fails
class ValidationException extends AppException {
  const ValidationException(super.message);
}