import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_execute.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/data_source/online_data_source/career/contract/career_online_datasource.dart';
import 'package:short_path/src/data/dto_models/career/extract_skills_dto.dart';
import 'package:short_path/src/data/dto_models/career/interview_preparation_dto.dart';
import 'package:short_path/src/domain/repositories/contract/career_repository.dart';

import '../../../domain/entities/career/cover_sheet_entity.dart';

@Injectable(as: CareerRepository)
class CareerRepositoryImpl implements CareerRepository {
  final CareerOnlineDatasource _careerOnlineDatasource;

  CareerRepositoryImpl(this._careerOnlineDatasource);

  @override
  Future<ApiResult<Response<ResponseBody>>> downloadFile(
      {String? jobDescription, int? jobId}) async {
    return await executeApi<Response<ResponseBody>>(apiCall: () async {
      var result = await _careerOnlineDatasource.downloadFile(
          jobDescription: jobDescription, jobId: jobId);
      return result;
    });
  }

  @override
  Future<ApiResult<CoverSheetEntity?>> generateCoverSheet(
      {String? jobDescription, int? jobId}) async {
    return await executeApi<CoverSheetEntity?>(apiCall: () async {
      var result = await _careerOnlineDatasource.generateCoverSheet(
          jobDescription: jobDescription, jobId: jobId);
      return result?.toEntity();
    });
  }

  @override
  Future<ApiResult<InterviewPreparationDto>> interviewPreparationByDescription(
      String? jobDescription) async {
    return await executeApi<InterviewPreparationDto>(apiCall: () async {
      var result = await _careerOnlineDatasource
          .interviewPreparationByDescription(jobDescription);
      return result;
    });
  }

  @override
  Future<ApiResult<InterviewPreparationDto>> interviewPreparationById(
      int? jobId) async {
    return await executeApi<InterviewPreparationDto>(apiCall: () async {
      var result =
          await _careerOnlineDatasource.interviewPreparationById(jobId);
      return result;
    });
  }

  @override
  Future<ApiResult<ExtractedSkillsDto>> extractSkills(String jobDescription) {
    return executeApi<ExtractedSkillsDto>(apiCall: () async {
      var result = await _careerOnlineDatasource.extractSkills(jobDescription);
      return result;
    });
  }
}
