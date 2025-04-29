// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobsResponse _$JobsResponseFromJson(Map<String, dynamic> json) => JobsResponse(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNumber: (json['pageNumber'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      totalElements: (json['totalElements'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      last: json['last'] as bool?,
      fullTimeJobsCount: (json['fullTimeJobsCount'] as num?)?.toInt(),
      partTimeJobsCount: (json['partTimeJobsCount'] as num?)?.toInt(),
      internshipJobsCount: (json['internshipJobsCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$JobsResponseToJson(JobsResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'last': instance.last,
      'fullTimeJobsCount': instance.fullTimeJobsCount,
      'partTimeJobsCount': instance.partTimeJobsCount,
      'internshipJobsCount': instance.internshipJobsCount,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
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

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
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
