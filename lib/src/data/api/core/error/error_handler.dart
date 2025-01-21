import 'package:dio/dio.dart';

class ErrorHandler {
  final String errorMassage;
  final int code;

  ErrorHandler._(this.errorMassage, this.code);

  factory ErrorHandler.fromException(dynamic exception) {
    if (exception is DioException) {
      // Extract the status code
      final statusCode = exception.response?.statusCode;

      switch (statusCode) {
        case 403:
          return ErrorHandler._("Wrong email or password", 403);
        case 401:
          return ErrorHandler._("Unauthorized access", 401);
        case 500:
          return ErrorHandler._("Internal server error", 500);
        default:
          return ErrorHandler._(
              "An error occurred with status code $statusCode",
              statusCode ?? -1);
      }
    } else {
      // Default fallback for unknown exceptions
      return ErrorHandler._("An unexpected error occurred", -1);
    }
  }
}
