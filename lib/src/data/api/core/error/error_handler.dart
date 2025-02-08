import 'package:dio/dio.dart';

class ErrorHandler {
  final String errorMessage;
  final int code;

  ErrorHandler._(this.errorMessage, this.code);

  factory ErrorHandler.fromException(dynamic exception) {
    if (exception is DioException) {
      final statusCode = exception.response?.statusCode;
      final responseData = exception.response?.data;

      // Extract error message from server response
      String message = "An error occurred";
      if (responseData is Map<String, dynamic>) {
        message = responseData['error'] ??
            responseData['detail'] ??
            responseData['message'] ??
            message;
      }

      // Handle token expiration specifically
      if (statusCode == 403 && message.contains("token has expired")) {
        // Perform token refresh or force logout
        return ErrorHandler._(
            "Session expired. Please log in again.", statusCode!);
      }

      return ErrorHandler._(message, statusCode ?? -1);
    } else {
      return ErrorHandler._("An unexpected error occurred", -1);
    }
  }
}
