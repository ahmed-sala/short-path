import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/career/cover_sheet_entity.dart';
import 'package:short_path/src/domain/repositories/contract/career_repository.dart';

@injectable
class CareerUsecase {
  final CareerRepository _careerRepository;
  CareerUsecase(this._careerRepository);
  Future<ApiResult<Response<ResponseBody>>> downloadFile() async {
    return await _careerRepository.downloadFile(
        "We are looking for a Senior Full-Stack Developer experienced with email ahmeds66210@gmail.com in PHP (Laravel), MySQL, and Docker. You will design scalable backends and integrate with modern frontends. Excellent proficiency in microservices, CI/CD pipelines with Jenkins, and container orchestration is required.");
  }

  Future<ApiResult<CoverSheetEntity?>> generateCoverSheet(
      String jobDescription) async {
    return await _careerRepository.generateCoverSheet(jobDescription);
  }
}
