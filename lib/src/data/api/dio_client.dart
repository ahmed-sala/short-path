import 'package:dio/dio.dart';

import 'core/constants/apis_baseurl.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApisBaseurl.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  static Future<Response<ResponseBody>> downloadPdf({
    required String endPoint,
    required String token,
  }) async {
    try {
      final response = await _dio.get<ResponseBody>(
        endPoint,
        options: Options(
          responseType: ResponseType.stream,
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final contentType = response.headers.value('content-type');
        if (contentType != null && contentType.contains('application/pdf')) {
          return response;
        } else {
          throw Exception("❌ Unexpected content type: $contentType");
        }
      } else {
        throw Exception('❌ Failed to download PDF: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('❌ Dio Error: $e');
    }
  }
}
