import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Provides a configured Dio instance with logging for debugging purposes.
@module
abstract class DioProvider {
  /// Provides a singleton Dio instance with default configurations and logging.
  @lazySingleton
  Dio dioProvider() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );

    // Add interceptors, such as logging.
    dio.interceptors.add(providePrettyDioLogger());
    return dio;
  }

  /// Configures PrettyDioLogger for better logging during development.
  @lazySingleton
  PrettyDioLogger providePrettyDioLogger() {
    return PrettyDioLogger(
      requestHeader: true, // Logs request headers.
      requestBody: true, // Logs request body.
      responseBody: true, // Logs response body.
      responseHeader: false, // Skip logging response headers for brevity.
      error: true, // Logs errors.
      compact: true, // Compact logging format for better readability.
      maxWidth: 90, // Sets the maximum width for log output.
      enabled: kDebugMode, // Enable logging only in debug mode.
    );
  }
}
