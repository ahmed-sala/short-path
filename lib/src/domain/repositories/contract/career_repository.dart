import 'package:dio/dio.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/career/cover_sheet_entity.dart';

abstract interface class CareerRepository {
  Future<ApiResult<Response<ResponseBody>>> downloadFile(String jobDescription);
  Future<ApiResult<CoverSheetEntity?>> generateCoverSheet(
      String jobDescription);
}
