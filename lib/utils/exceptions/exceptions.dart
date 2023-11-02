class ValidationException implements Exception {
  final String message;

  ValidationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class DataException implements Exception {
  final String message;

  DataException(this.message);

  @override
  String toString() => 'DataException: $message';
}

class PermissionException implements Exception {
  final String message;

  PermissionException(this.message);

  @override
  String toString() => 'PermissionException: $message';
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException(this.message);

  @override
  String toString() => 'AuthenticationException: $message';
}

class FileException implements Exception {
  final String message;

  FileException(this.message);

  @override
  String toString() => 'FileException: $message';
}

class CustomAppException implements Exception {
  final String message;

  CustomAppException(this.message);

  @override
  String toString() => 'CustomAppException: $message';
}

class PaymentException implements Exception {
  final String message;

  PaymentException(this.message);

  @override
  String toString() => 'PaymentException: $message';
}

class PermissionDeniedException implements Exception {
  final String message;

  PermissionDeniedException(this.message);

  @override
  String toString() => 'PermissionDeniedException: $message';
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);

  @override
  String toString() => 'DatabaseException: $message';
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);

  @override
  String toString() => 'NotFoundException: $message';
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);

  @override
  String toString() => 'UnauthorizedException: $message';
}

class FileIOException implements Exception {
  final String message;

  FileIOException(this.message);

  @override
  String toString() => 'FileIOException: $message';
}

class NotFoundInDatabaseException implements Exception {
  final String message;

  NotFoundInDatabaseException(this.message);

  @override
  String toString() => 'NotFoundInDatabaseException: $message';
}
