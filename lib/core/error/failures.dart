import 'package:equatable/equatable.dart';
import 'exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;
  final Map<String, dynamic>? data;

  const Failure({required this.message, this.code, this.data});

  @override
  List<Object?> get props => [message, code, data];

  @override
  String toString() {
    return 'Failure{message: $message, code: $code}';
  }
}

// Server Failures
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'ServerFailure{message: $message, code: $code}';
  }
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'NetworkFailure{message: $message, code: $code}';
  }
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'TimeoutFailure{message: $message, code: $code}';
  }
}

// Authentication Failures
class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'AuthFailure{message: $message, code: $code}';
  }
}

class UnauthorizedFailure extends AuthFailure {
  const UnauthorizedFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'UnauthorizedFailure{message: $message, code: $code}';
  }
}

class ForbiddenFailure extends AuthFailure {
  const ForbiddenFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'ForbiddenFailure{message: $message, code: $code}';
  }
}

class TokenExpiredFailure extends AuthFailure {
  const TokenExpiredFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'TokenExpiredFailure{message: $message, code: $code}';
  }
}

// Validation Failures
class ValidationFailure extends Failure {
  final Map<String, List<String>>? errors;

  const ValidationFailure({
    required super.message,
    super.code,
    this.errors,
    super.data,
  });

  @override
  List<Object?> get props => [message, code, errors, data];

  @override
  String toString() {
    return 'ValidationFailure{message: $message, code: $code, errors: $errors}';
  }
}

class InvalidInputFailure extends ValidationFailure {
  const InvalidInputFailure({
    required super.message,
    super.code,
    super.errors,
    super.data,
  });

  @override
  String toString() {
    return 'InvalidInputFailure{message: $message, code: $code}';
  }
}

// Data Failures
class DataFailure extends Failure {
  const DataFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'DataFailure{message: $message, code: $code}';
  }
}

class NotFoundFailure extends DataFailure {
  const NotFoundFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'NotFoundFailure{message: $message, code: $code}';
  }
}

class ConflictFailure extends DataFailure {
  const ConflictFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'ConflictFailure{message: $message, code: $code}';
  }
}

class DuplicateFailure extends DataFailure {
  const DuplicateFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'DuplicateFailure{message: $message, code: $code}';
  }
}

// Cache Failures
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'CacheFailure{message: $message, code: $code}';
  }
}

// Storage Failures
class StorageFailure extends Failure {
  const StorageFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'StorageFailure{message: $message, code: $code}';
  }
}

class FileUploadFailure extends StorageFailure {
  const FileUploadFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'FileUploadFailure{message: $message, code: $code}';
  }
}

class FileSizeFailure extends StorageFailure {
  const FileSizeFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'FileSizeFailure{message: $message, code: $code}';
  }
}

class FileTypeFailure extends StorageFailure {
  const FileTypeFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'FileTypeFailure{message: $message, code: $code}';
  }
}

// Permission Failures
class PermissionFailure extends Failure {
  const PermissionFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'PermissionFailure{message: $message, code: $code}';
  }
}

class LocationPermissionFailure extends PermissionFailure {
  const LocationPermissionFailure({
    required super.message,
    super.code,
    super.data,
  });

  @override
  String toString() {
    return 'LocationPermissionFailure{message: $message, code: $code}';
  }
}

class CameraPermissionFailure extends PermissionFailure {
  const CameraPermissionFailure({
    required super.message,
    super.code,
    super.data,
  });

  @override
  String toString() {
    return 'CameraPermissionFailure{message: $message, code: $code}';
  }
}

class NotificationPermissionFailure extends PermissionFailure {
  const NotificationPermissionFailure({
    required super.message,
    super.code,
    super.data,
  });

  @override
  String toString() {
    return 'NotificationPermissionFailure{message: $message, code: $code}';
  }
}

// Business Logic Failures
class BusinessFailure extends Failure {
  const BusinessFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'BusinessFailure{message: $message, code: $code}';
  }
}

class MembershipFailure extends BusinessFailure {
  const MembershipFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'MembershipFailure{message: $message, code: $code}';
  }
}

class ClassFullFailure extends BusinessFailure {
  const ClassFullFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'ClassFullFailure{message: $message, code: $code}';
  }
}

class ReservationFailure extends BusinessFailure {
  const ReservationFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'ReservationFailure{message: $message, code: $code}';
  }
}

class PaymentFailure extends BusinessFailure {
  const PaymentFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'PaymentFailure{message: $message, code: $code}';
  }
}

class InsufficientCreditsFailure extends BusinessFailure {
  const InsufficientCreditsFailure({
    required super.message,
    super.code,
    super.data,
  });

  @override
  String toString() {
    return 'InsufficientCreditsFailure{message: $message, code: $code}';
  }
}

class CancellationPeriodExpiredFailure extends BusinessFailure {
  const CancellationPeriodExpiredFailure({
    required super.message,
    super.code,
    super.data,
  });

  @override
  String toString() {
    return 'CancellationPeriodExpiredFailure{message: $message, code: $code}';
  }
}

// Device Failures
class DeviceFailure extends Failure {
  const DeviceFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'DeviceFailure{message: $message, code: $code}';
  }
}

class BiometricFailure extends DeviceFailure {
  const BiometricFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'BiometricFailure{message: $message, code: $code}';
  }
}

class LocationFailure extends DeviceFailure {
  const LocationFailure({required super.message, super.code, super.data});

  @override
  String toString() {
    return 'LocationFailure{message: $message, code: $code}';
  }
}

// Failure Factory
class FailureFactory {
  static Failure fromException(AppException exception) {
    switch (exception.runtimeType) {
      case ServerException _:
        return ServerFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case NetworkException _:
        return NetworkFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case TimeoutException _:
        return TimeoutFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case UnauthorizedException _:
        return UnauthorizedFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case ForbiddenException _:
        return ForbiddenFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case TokenExpiredException _:
        return TokenExpiredFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case InvalidInputException _:
        final inputException = exception as InvalidInputException;
        return InvalidInputFailure(
          message: exception.message,
          code: exception.code,
          errors: inputException.errors,
          data: {'originalError': exception.originalError},
        );

      case ValidationException _:
        final validationException = exception as ValidationException;
        return ValidationFailure(
          message: exception.message,
          code: exception.code,
          errors: validationException.errors,
          data: {'originalError': exception.originalError},
        );

      case NotFoundException _:
        return NotFoundFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case ConflictException _:
        return ConflictFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case DuplicateException _:
        return DuplicateFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case CacheException _:
        return CacheFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case FileUploadException _:
        return FileUploadFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case FileSizeException _:
        return FileSizeFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case FileTypeException _:
        return FileTypeFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case LocationPermissionException _:
        return LocationPermissionFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case CameraPermissionException _:
        return CameraPermissionFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case NotificationPermissionException _:
        return NotificationPermissionFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case MembershipException _:
        return MembershipFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case ClassFullException _:
        return ClassFullFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case ReservationException _:
        return ReservationFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case PaymentException _:
        return PaymentFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case InsufficientCreditsException _:
        return InsufficientCreditsFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case CancellationPeriodExpiredException _:
        return CancellationPeriodExpiredFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case BiometricException _:
        return BiometricFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      case LocationException _:
        return LocationFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );

      default:
        // For AuthException and other general exceptions
        if (exception is AuthException) {
          return AuthFailure(
            message: exception.message,
            code: exception.code,
            data: {'originalError': exception.originalError},
          );
        }

        if (exception is BusinessException) {
          return BusinessFailure(
            message: exception.message,
            code: exception.code,
            data: {'originalError': exception.originalError},
          );
        }

        if (exception is StorageException) {
          return StorageFailure(
            message: exception.message,
            code: exception.code,
            data: {'originalError': exception.originalError},
          );
        }

        if (exception is PermissionException) {
          return PermissionFailure(
            message: exception.message,
            code: exception.code,
            data: {'originalError': exception.originalError},
          );
        }

        if (exception is DeviceException) {
          return DeviceFailure(
            message: exception.message,
            code: exception.code,
            data: {'originalError': exception.originalError},
          );
        }

        if (exception is DataException) {
          return DataFailure(
            message: exception.message,
            code: exception.code,
            data: {'originalError': exception.originalError},
          );
        }

        // Default fallback
        return ServerFailure(
          message: exception.message,
          code: exception.code,
          data: {'originalError': exception.originalError},
        );
    }
  }

  static Failure createNetworkFailure([String? message]) {
    return NetworkFailure(
      message:
          message ??
          'Network connection failed. Please check your internet connection.',
      code: 'NETWORK_ERROR',
    );
  }

  static Failure createTimeoutFailure([String? message]) {
    return TimeoutFailure(
      message: message ?? 'Request timeout. Please try again.',
      code: 'TIMEOUT_ERROR',
    );
  }

  static Failure createUnauthorizedFailure([String? message]) {
    return UnauthorizedFailure(
      message: message ?? 'You are not authorized to perform this action.',
      code: 'UNAUTHORIZED',
    );
  }

  static Failure createValidationFailure(
    String message, [
    Map<String, List<String>>? errors,
  ]) {
    return ValidationFailure(
      message: message,
      code: 'VALIDATION_ERROR',
      errors: errors,
    );
  }

  static Failure createBusinessFailure(String message, [String? code]) {
    return BusinessFailure(
      message: message,
      code: code ?? 'BUSINESS_RULE_VIOLATION',
    );
  }
}
