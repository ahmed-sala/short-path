import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/user_info/Certification_Entity.dart';
import 'package:short_path/src/domain/repositories/contract/user_info_repository.dart';

@injectable
class CertificationUsecase {
  final UserInfoRepository _userInfoRepository;
  CertificationUsecase(this._userInfoRepository);
  Future<ApiResult<void>> addCertification(
      CertificationsEntity certification) async {
    return await _userInfoRepository.saveCertification(certification);
  }

  void removeCertification(CertificationEntity certification) {
    print('${certification.certificationName} removed!');
  }
}
