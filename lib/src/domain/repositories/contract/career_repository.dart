import 'package:dio/dio.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/career/cover_sheet_entity.dart';

import '../../../data/dto_models/career/interview_preparation_dto.dart';

abstract interface class CareerRepository {
  Future<ApiResult<Response<ResponseBody>>> downloadFile(
      {String? jobDescription, int? jobId});
  Future<ApiResult<CoverSheetEntity?>> generateCoverSheet(
      {String? jobDescription, int? jobId});
  Future<ApiResult<InterviewPreparationDto>>interviewPreparationById(
      int? jobId
      );
  Future<ApiResult<InterviewPreparationDto>> interviewPreparationByDescription(
      String? jobDescription);
}
