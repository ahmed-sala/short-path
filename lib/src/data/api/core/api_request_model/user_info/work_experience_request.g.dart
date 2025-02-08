// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_experience_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkExperienceRequest _$WorkExperienceRequestFromJson(
        Map<String, dynamic> json) =>
    WorkExperienceRequest(
      workExperiences: (json['workExperiences'] as List<dynamic>?)
          ?.map((e) => WorkExperiences.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkExperienceRequestToJson(
        WorkExperienceRequest instance) =>
    <String, dynamic>{
      'workExperiences': instance.workExperiences,
    };

WorkExperiences _$WorkExperiencesFromJson(Map<String, dynamic> json) =>
    WorkExperiences(
      jobTitle: json['jobTitle'] as String?,
      companyName: json['companyName'] as String?,
      companyField: json['companyField'] as String?,
      jobType: json['jobType'] as String?,
      jobLocation: json['jobLocation'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      summary: json['summary'] as String?,
      toolsTechnologiesUsed: (json['toolsTechnologiesUsed'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$WorkExperiencesToJson(WorkExperiences instance) =>
    <String, dynamic>{
      'jobTitle': instance.jobTitle,
      'companyName': instance.companyName,
      'companyField': instance.companyField,
      'jobType': instance.jobType,
      'jobLocation': instance.jobLocation,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'summary': instance.summary,
      'toolsTechnologiesUsed': instance.toolsTechnologiesUsed,
    };
