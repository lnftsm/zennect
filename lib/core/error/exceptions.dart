abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() {
    return 'AppException{message: $message, code: $code}';
  }
}

// Server Exceptions
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'ServerException{message: $message, code: $code}';
  }
}

class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'NetworkException{message: $message, code: $code}';
  }
}

class TimeoutException extends AppException {
  const TimeoutException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'TimeoutException{message: $message, code: $code}';
  }
}

// Authentication Exceptions
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'AuthException{message: $message, code: $code}';
  }
}

class UnauthorizedException extends AuthException {
  const UnauthorizedException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'UnauthorizedException{message: $message, code: $code}';
  }
}

class ForbiddenException extends AuthException {
  const ForbiddenException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'ForbiddenException{message: $message, code: $code}';
  }
}

class TokenExpiredException extends AuthException {
  const TokenExpiredException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'TokenExpiredException{message: $message, code: $code}';
  }
}

// Validation Exceptions
class ValidationException extends AppException {
  final Map<String, List<String>>? errors;

  const ValidationException({
    required super.message,
    super.code,
    this.errors,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'ValidationException{message: $message, code: $code, errors: $errors}';
  }
}

class InvalidInputException extends ValidationException {
  const InvalidInputException({
    required super.message,
    super.code,
    super.errors,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'InvalidInputException{message: $message, code: $code}';
  }
}

// Data Exceptions
class DataException extends AppException {
  const DataException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'DataException{message: $message, code: $code}';
  }
}

class NotFoundException extends DataException {
  const NotFoundException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'NotFoundException{message: $message, code: $code}';
  }
}

class ConflictException extends DataException {
  const ConflictException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'ConflictException{message: $message, code: $code}';
  }
}

class DuplicateException extends DataException {
  const DuplicateException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'DuplicateException{message: $message, code: $code}';
  }
}

// Cache Exceptions
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'CacheException{message: $message, code: $code}';
  }
}

// Storage Exceptions
class StorageException extends AppException {
  const StorageException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'StorageException{message: $message, code: $code}';
  }
}

class FileUploadException extends StorageException {
  const FileUploadException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'FileUploadException{message: $message, code: $code}';
  }
}

class FileSizeException extends StorageException {
  const FileSizeException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'FileSizeException{message: $message, code: $code}';
  }
}

class FileTypeException extends StorageException {
  const FileTypeException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'FileTypeException{message: $message, code: $code}';
  }
}

// Permission Exceptions
class PermissionException extends AppException {
  const PermissionException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'PermissionException{message: $message, code: $code}';
  }
}

class LocationPermissionException extends PermissionException {
  const LocationPermissionException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'LocationPermissionException{message: $message, code: $code}';
  }
}

class CameraPermissionException extends PermissionException {
  const CameraPermissionException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'CameraPermissionException{message: $message, code: $code}';
  }
}

class NotificationPermissionException extends PermissionException {
  const NotificationPermissionException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'NotificationPermissionException{message: $message, code: $code}';
  }
}

// Business Logic Exceptions
class BusinessException extends AppException {
  const BusinessException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'BusinessException{message: $message, code: $code}';
  }
}

class MembershipException extends BusinessException {
  const MembershipException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'MembershipException{message: $message, code: $code}';
  }
}

class ClassFullException extends BusinessException {
  const ClassFullException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'ClassFullException{message: $message, code: $code}';
  }
}

class ReservationException extends BusinessException {
  const ReservationException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'ReservationException{message: $message, code: $code}';
  }
}

class PaymentException extends BusinessException {
  const PaymentException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'PaymentException{message: $message, code: $code}';
  }
}

class InsufficientCreditsException extends BusinessException {
  const InsufficientCreditsException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'InsufficientCreditsException{message: $message, code: $code}';
  }
}

class CancellationPeriodExpiredException extends BusinessException {
  const CancellationPeriodExpiredException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'CancellationPeriodExpiredException{message: $message, code: $code}';
  }
}

// Device Exceptions
class DeviceException extends AppException {
  const DeviceException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'DeviceException{message: $message, code: $code}';
  }
}

class BiometricException extends DeviceException {
  const BiometricException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'BiometricException{message: $message, code: $code}';
  }
}

class LocationException extends DeviceException {
  const LocationException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'LocationException{message: $message, code: $code}';
  }
}

// Platform Exceptions
class PlatformException extends AppException {
  const PlatformException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'PlatformException{message: $message, code: $code}';
  }
}

// Notification Exceptions
class NotificationException extends AppException {
  const NotificationException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'NotificationException{message: $message, code: $code}';
  }
}

// Sync Exceptions
class SyncException extends AppException {
  const SyncException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'SyncException{message: $message, code: $code}';
  }
}

// Configuration Exceptions
class ConfigurationException extends AppException {
  const ConfigurationException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'ConfigurationException{message: $message, code: $code}';
  }
}

// Parser Exceptions
class ParseException extends AppException {
  const ParseException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'ParseException{message: $message, code: $code}';
  }
}

// Exception Factory
class ExceptionFactory {
  static AppException fromError(dynamic error, [StackTrace? stackTrace]) {
    if (error is AppException) {
      return error;
    }

    String message;
    String? code;

    if (error is Exception) {
      message = error.toString();
    } else {
      message = error?.toString() ?? 'Unknown error occurred';
    }

    // Try to determine exception type based on error message or type
    if (message.contains('network') || message.contains('connection')) {
      return NetworkException(
        message: message,
        code: code,
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    if (message.contains('timeout')) {
      return TimeoutException(
        message: message,
        code: code,
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    if (message.contains('unauthorized') || message.contains('401')) {
      return UnauthorizedException(
        message: message,
        code: code,
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    if (message.contains('forbidden') || message.contains('403')) {
      return ForbiddenException(
        message: message,
        code: code,
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    if (message.contains('not found') || message.contains('404')) {
      return NotFoundException(
        message: message,
        code: code,
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    if (message.contains('validation') || message.contains('invalid')) {
      return ValidationException(
        message: message,
        code: code,
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    // Default to general server exception
    return ServerException(
      message: message,
      code: code,
      originalError: error,
      stackTrace: stackTrace,
    );
  }

  static AppException createNetworkException([String? message]) {
    return NetworkException(
      message:
          message ??
          'Network connection failed. Please check your internet connection.',
      code: 'NETWORK_ERROR',
    );
  }

  static AppException createTimeoutException([String? message]) {
    return TimeoutException(
      message: message ?? 'Request timeout. Please try again.',
      code: 'TIMEOUT_ERROR',
    );
  }

  static AppException createUnauthorizedException([String? message]) {
    return UnauthorizedException(
      message: message ?? 'You are not authorized to perform this action.',
      code: 'UNAUTHORIZED',
    );
  }

  static AppException createValidationException(
    String message, [
    Map<String, List<String>>? errors,
  ]) {
    return ValidationException(
      message: message,
      code: 'VALIDATION_ERROR',
      errors: errors,
    );
  }

  static AppException createBusinessException(String message, [String? code]) {
    return BusinessException(
      message: message,
      code: code ?? 'BUSINESS_RULE_VIOLATION',
    );
  }
}
