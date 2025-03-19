import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:short_path/src/data/dto_models/user_info/certification_do.dart';

part 'certificate_respone.g.dart';

@JsonSerializable()
class CertificateResponse {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "certificationName")
  final String? certificationName;
  @JsonKey(name: "issuingOrganization")
  final String? issuingOrganization;
  @JsonKey(name: "dateEarned")
  @LocalDateConverter()
  final DateTime? dateEarned;
  @JsonKey(name: "expirationDate")
  @LocalDateConverter()
  final DateTime? expirationDate;

  CertificateResponse({
    this.id,
    this.certificationName,
    this.issuingOrganization,
    this.dateEarned,
    this.expirationDate,
  });

  factory CertificateResponse.fromJson(Map<String, dynamic> json) {
    return _$CertificateResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CertificateResponseToJson(this);
  }

  CertificationsDto toDto() {
    return CertificationsDto(
      certificationName: certificationName,
      issuingOrganization: issuingOrganization,
      dateEarned: dateEarned,
      expirationDate: expirationDate,
    );
  }
}

class LocalDateConverter implements JsonConverter<DateTime?, String?> {
  const LocalDateConverter();

  @override
  DateTime? fromJson(String? json) {
    return json != null ? DateTime.parse(json) : null;
  }

  @override
  String? toJson(DateTime? date) {
    return date != null ? DateFormat("yyyy-MM-dd").format(date) : null;
  }
}
