// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_respone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificateResponse _$CertificateResponseFromJson(Map<String, dynamic> json) =>
    CertificateResponse(
      id: (json['id'] as num?)?.toInt(),
      certificationName: json['certificationName'] as String?,
      issuingOrganization: json['issuingOrganization'] as String?,
      dateEarned:
          const LocalDateConverter().fromJson(json['dateEarned'] as String?),
      expirationDate: const LocalDateConverter()
          .fromJson(json['expirationDate'] as String?),
    );

Map<String, dynamic> _$CertificateResponseToJson(
        CertificateResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'certificationName': instance.certificationName,
      'issuingOrganization': instance.issuingOrganization,
      'dateEarned': const LocalDateConverter().toJson(instance.dateEarned),
      'expirationDate':
          const LocalDateConverter().toJson(instance.expirationDate),
    };
