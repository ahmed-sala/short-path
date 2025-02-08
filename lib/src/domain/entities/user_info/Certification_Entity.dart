import 'package:short_path/src/data/dto_models/user_info/certification_do.dart';

class CertificationsEntity {
  final List<CertificationEntity> certifications;

  CertificationsEntity({
    required this.certifications,
  });

  CertificationDto toDto() {
    return CertificationDto(
      certifications: certifications.map((e) => e.toDto()).toList(),
    );
  }
}

class CertificationEntity {
  final String certificationName;
  final String issuingOrganization;
  final DateTime? dateEarned;
  final DateTime? expirationDate;

  CertificationEntity({
    required this.certificationName,
    required this.issuingOrganization,
    required this.dateEarned,
    required this.expirationDate,
  });
  CertificationsDto toDto() {
    return CertificationsDto(
      certificationName: certificationName,
      issuingOrganization: issuingOrganization,
      dateEarned: dateEarned,
      expirationDate: expirationDate,
    );
  }
}
