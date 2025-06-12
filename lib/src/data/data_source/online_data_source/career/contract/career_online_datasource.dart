import 'package:dio/dio.dart';
import 'package:short_path/src/data/dto_models/career/cover_sheet_dto.dart';

import '../../../../dto_models/career/extract_skills_dto.dart';
import '../../../../dto_models/career/interview_preparation_dto.dart';

abstract interface class CareerOnlineDatasource {
  Future<Response<ResponseBody>> downloadFile(
      {String? jobDescription, int? jobId});

  Future<CoverSheetDto?> generateCoverSheet(
      {String? jobDescription, int? jobId});

  Future<InterviewPreparationDto> interviewPreparationById(int? jobId);

  Future<InterviewPreparationDto> interviewPreparationByDescription(
      String? jobDescription);

  Future<ExtractedSkillsDto> extractSkills(String jobDescription);
}
