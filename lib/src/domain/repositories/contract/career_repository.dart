import 'package:dio/dio.dart';
import 'package:short_path/core/common/api/api_result.dart';

abstract interface class CareerRepository {
  Future<ApiResult<Response<ResponseBody>>> downloadFile(String jobDescription);
  Future<ApiResult<String?>> generateCoverSheet(String jobDescription);
}
