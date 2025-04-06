// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_experience_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkExperienceResponse _$WorkExperienceResponseFromJson(
        Map<String, dynamic> json) =>
    WorkExperienceResponse(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      jobTitle: json['jobTitle'] as String?,
      companyName: json['companyName'] as String?,
      companyField: json['companyField'] as String?,
      jobType: json['jobType'] as String?,
      jobLocation: json['jobLocation'] as String?,
      startDate:
          const LocalDateConverter().fromJson(json['startDate'] as String?),
      endDate: const LocalDateConverter().fromJson(json['endDate'] as String?),
      summary: json['summary'] as String?,
      toolsTechnologiesUsed: (json['toolsTechnologiesUsed'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$WorkExperienceResponseToJson(
        WorkExperienceResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'jobTitle': instance.jobTitle,
      'companyName': instance.companyName,
      'companyField': instance.companyField,
      'jobType': instance.jobType,
      'jobLocation': instance.jobLocation,
      'startDate': const LocalDateConverter().toJson(instance.startDate),
      'endDate': const LocalDateConverter().toJson(instance.endDate),
      'summary': instance.summary,
      'toolsTechnologiesUsed': instance.toolsTechnologiesUsed,
    };
