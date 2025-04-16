import 'package:dio/dio.dart';

import 'core/constants/apis_baseurl.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApisBaseurl.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  static Future<Response<ResponseBody>> downloadPdf({
    required String endPoint,
    required String token,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _dio.post<ResponseBody>(
        endPoint,
        data: data,
        options: Options(
          responseType: ResponseType.stream,
          headers: {
            'Authorization': 'Bearer $token',
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
