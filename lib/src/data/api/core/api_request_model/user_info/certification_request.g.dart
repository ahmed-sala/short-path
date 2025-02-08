// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificationRequest _$CertificationRequestFromJson(
        Map<String, dynamic> json) =>
    CertificationRequest(
      certifications: (json['certifications'] as List<dynamic>?)
          ?.map((e) => Certifications.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CertificationRequestToJson(
        CertificationRequest instance) =>
    <String, dynamic>{
      'certifications': instance.certifications,
    };

Certifications _$CertificationsFromJson(Map<String, dynamic> json) =>
    Certifications(
      certificationName: json['certificationName'] as String?,
      issuingOrganization: json['issuingOrganization'] as String?,
      dateEarned:
          const LocalDateConverter().fromJson(json['dateEarned'] as String?),
      expirationDate: const LocalDateConverter()
          .fromJson(json['expirationDate'] as String?),
    );

Map<String, dynamic> _$CertificationsToJson(Certifications instance) =>
    <String, dynamic>{
      'certificationName': instance.certificationName,
      'issuingOrganization': instance.issuingOrganization,
      'dateEarned': const LocalDateConverter().toJson(instance.dateEarned),
      'expirationDate':
          const LocalDateConverter().toJson(instance.expirationDate),
    };
