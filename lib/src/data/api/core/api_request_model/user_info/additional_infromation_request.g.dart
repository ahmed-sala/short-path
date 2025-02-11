// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_infromation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalInfromationRequest _$AdditionalInfromationRequestFromJson(
        Map<String, dynamic> json) =>
    AdditionalInfromationRequest(
      additionalInformation: json['additionalInformation'] == null
          ? null
          : AdditionalInformation.fromJson(
              json['additionalInformation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdditionalInfromationRequestToJson(
        AdditionalInfromationRequest instance) =>
    <String, dynamic>{
      'additionalInformation': instance.additionalInformation,
    };

AdditionalInformation _$AdditionalInformationFromJson(
        Map<String, dynamic> json) =>
    AdditionalInformation(
      hobbiesAndInterests: (json['hobbiesAndInterests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      publications: (json['publications'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      awardsAndHonors: (json['awardsAndHonors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      volunteerWork: (json['volunteerWork'] as List<dynamic>?)
          ?.map((e) => VolunteerWork.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdditionalInformationToJson(
        AdditionalInformation instance) =>
    <String, dynamic>{
      'hobbiesAndInterests': instance.hobbiesAndInterests,
      'publications': instance.publications,
      'awardsAndHonors': instance.awardsAndHonors,
      'volunteerWork': instance.volunteerWork,
    };

VolunteerWork _$VolunteerWorkFromJson(Map<String, dynamic> json) =>
    VolunteerWork(
      organizationName: json['organizationName'] as String?,
      role: json['role'] as String?,
      duration: json['duration'] == null
          ? null
          : DurationRequest.fromJson(json['duration'] as Map<String, dynamic>),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$VolunteerWorkToJson(VolunteerWork instance) =>
    <String, dynamic>{
      'organizationName': instance.organizationName,
      'role': instance.role,
      'duration': instance.duration,
      'description': instance.description,
    };

DurationRequest _$DurationRequestFromJson(Map<String, dynamic> json) =>
    DurationRequest(
      years: (json['years'] as num?)?.toInt(),
      months: (json['months'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DurationRequestToJson(DurationRequest instance) =>
    <String, dynamic>{
      'years': instance.years,
      'months': instance.months,
    };
