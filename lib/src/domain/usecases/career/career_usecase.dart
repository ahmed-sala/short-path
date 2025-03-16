import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/repositories/contract/career_repository.dart';

@injectable
class CareerUsecase {
  CareerRepository _careerRepository;
  CareerUsecase(this._careerRepository);
  Future<ApiResult<String>> downloadFile() async {
    return await _careerRepository.downloadFile();
  }
}
