import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/career/cover_sheet_entity.dart';
import 'package:short_path/src/domain/repositories/contract/career_repository.dart';

import '../../../data/dto_models/career/interview_preparation_dto.dart';

@injectable
class CareerUsecase {
  final CareerRepository _careerRepository;
  CareerUsecase(this._careerRepository);
  Future<ApiResult<Response<ResponseBody>>> downloadFile(
      {String? jobDescription, int? jobId}) async {
    return await _careerRepository.downloadFile(
      jobId: jobId,
      jobDescription: jobDescription,
    );
  }

  Future<ApiResult<CoverSheetEntity?>> generateCoverSheet(
      {String? jobDescription, int? jobId}) async {
    return await _careerRepository.generateCoverSheet(
        jobId: jobId, jobDescription: jobDescription);
  }
  Future<ApiResult<InterviewPreparationDto>> interviewPreparationById(
      int? jobId) async {
    return await _careerRepository.interviewPreparationById(jobId);
  }
  Future<ApiResult<InterviewPreparationDto>> interviewPreparationByDescription(
      String? jobDescription) async {
    return await _careerRepository.interviewPreparationByDescription(jobDescription);
  }
}
