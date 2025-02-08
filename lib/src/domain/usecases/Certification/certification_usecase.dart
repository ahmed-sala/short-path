import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/repositories/contract/user_info_repository.dart';

import '../../entities/user_info/Certification_Entity.dart';

@injectable
class CertificationUsecase {
  UserInfoRepository _userInfoRepository;
  CertificationUsecase(this._userInfoRepository);
  Future<ApiResult<void>> addCertification(
      CertificationsEntity certification) async {
    return await _userInfoRepository.saveCertification(certification);
  }

  void removeCertification(CertificationEntity certification) {
    print('${certification.certificationName} removed!');
  }
}
