// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobsResponse _$JobsResponseFromJson(Map<String, dynamic> json) => JobsResponse(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      company: json['company'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      location: json['location'] as String?,
      employmentType: json['employmentType'] as String?,
      datePosted: json['datePosted'] as String?,
      salaryRange: json['salaryRange'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$JobsResponseToJson(JobsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'company': instance.company,
      'description': instance.description,
      'image': instance.image,
      'location': instance.location,
      'employmentType': instance.employmentType,
      'datePosted': instance.datePosted,
      'salaryRange': instance.salaryRange,
      'url': instance.url,
    };
