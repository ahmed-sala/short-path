import 'package:short_path/src/data/api/core/api_request_model/user_info/certification_request.dart';

class CertificationDto {
  CertificationDto({
    List<CertificationsDto>? certifications,
  }) {
    _certifications = certifications;
  }

  CertificationDto.fromJson(dynamic json) {
    if (json['certifications'] != null) {
      _certifications = [];
      json['certifications'].forEach((v) {
        _certifications?.add(CertificationsDto.fromJson(v));
      });
    }
  }
  List<CertificationsDto>? _certifications;

  List<CertificationsDto>? get certifications => _certifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_certifications != null) {
      map['certifications'] = _certifications?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  CertificationRequest toRequest() {
    return CertificationRequest(
      certifications: _certifications?.map((e) => e.toRequest()).toList(),
    );
  }
}

class CertificationsDto {
  CertificationsDto({
    String? certificationName,
    String? issuingOrganization,
    DateTime? dateEarned,
    DateTime? expirationDate,
  }) {
    _certificationName = certificationName;
    _issuingOrganization = issuingOrganization;
    _dateEarned = dateEarned;
    _expirationDate = expirationDate;
  }

  CertificationsDto.fromJson(dynamic json) {
    _certificationName = json['certificationName'];
    _issuingOrganization = json['issuingOrganization'];
    _dateEarned = json['dateEarned'];
    _expirationDate = json['expirationDate'];
  }
  String? _certificationName;
  String? _issuingOrganization;
  DateTime? _dateEarned;
  DateTime? _expirationDate;

  String? get certificationName => _certificationName;
  String? get issuingOrganization => _issuingOrganization;
  DateTime? get dateEarned => _dateEarned;
  DateTime? get expirationDate => _expirationDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['certificationName'] = _certificationName;
    map['issuingOrganization'] = _issuingOrganization;
    map['dateEarned'] = _dateEarned;
    map['expirationDate'] = _expirationDate;
    return map;
  }

  Certifications toRequest() {
    return Certifications(
      certificationName: certificationName,
      issuingOrganization: issuingOrganization,
      dateEarned: dateEarned,
      expirationDate: expirationDate,
    );
  }
}
