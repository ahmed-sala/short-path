// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalInfoResponse _$AdditionalInfoResponseFromJson(
        Map<String, dynamic> json) =>
    AdditionalInfoResponse(
      id: (json['id'] as num?)?.toInt(),
      volunteerWork: (json['volunteerWork'] as List<dynamic>?)
          ?.map((e) => VolunteerWork.fromJson(e as Map<String, dynamic>))
          .toList(),
      hobbiesAndInterests: (json['hobbiesAndInterests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      publications: (json['publications'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      awardsAndHonors: (json['awardsAndHonors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AdditionalInfoResponseToJson(
        AdditionalInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'volunteerWork': instance.volunteerWork,
      'hobbiesAndInterests': instance.hobbiesAndInterests,
      'publications': instance.publications,
      'awardsAndHonors': instance.awardsAndHonors,
    };

VolunteerWork _$VolunteerWorkFromJson(Map<String, dynamic> json) =>
    VolunteerWork(
      id: (json['id'] as num?)?.toInt(),
      organizationName: json['organizationName'] as String?,
      role: json['role'] as String?,
      duration: json['duration'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$VolunteerWorkToJson(VolunteerWork instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationName': instance.organizationName,
      'role': instance.role,
      'duration': instance.duration,
      'description': instance.description,
    };
