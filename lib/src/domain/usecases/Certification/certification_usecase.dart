import 'package:injectable/injectable.dart';
import '../../entities/infromation_gathering/Certification_Entity.dart';

@injectable
class CertificationUsecase {
  void addCertification(CertificationEntity certification) {
    print('Certification Name: ${certification.certificationName}');
    print('Issuing Organization: ${certification.issuingOrganization}');
    print('Date Earned: ${certification.dateEarned}');
    print('Expiration Date: ${certification.expirationDate}');
  }

  void removeCertification(CertificationEntity certification) {
    print('${certification.certificationName} removed!');
  }
}
