import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'certification_request.g.dart';

@JsonSerializable()
class CertificationRequest {
  @JsonKey(name: "certifications")
  final List<Certifications>? certifications;

  CertificationRequest({
    this.certifications,
  });

  factory CertificationRequest.fromJson(Map<String, dynamic> json) {
    return _$CertificationRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CertificationRequestToJson(this);
  }
}

@JsonSerializable()
class Certifications {
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

  Certifications({
    this.certificationName,
    this.issuingOrganization,
    this.dateEarned,
    this.expirationDate,
  });

  factory Certifications.fromJson(Map<String, dynamic> json) {
    return _$CertificationsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CertificationsToJson(this);
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
