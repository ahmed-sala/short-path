import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/user_info/additional_info_entity.dart';
import 'package:short_path/src/domain/repositories/contract/user_info_repository.dart';

@injectable
class AdditionalInfoUsecase {
  final UserInfoRepository _userInfoRepository;
  AdditionalInfoUsecase(this._userInfoRepository);
  Future<ApiResult<void>> invoke(AdditionalInfoEntity additionalInfo) async {
    return await _userInfoRepository.saveAdditionalInfo(additionalInfo);
  }
}
