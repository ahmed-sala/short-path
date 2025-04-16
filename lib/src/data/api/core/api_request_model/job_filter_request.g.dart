// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_filter_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobFilterRequest _$JobFilterRequestFromJson(Map<String, dynamic> json) =>
    JobFilterRequest(
      datePosted: json['datePosted'] == null
          ? null
          : DatePosted.fromJson(json['datePosted'] as Map<String, dynamic>),
      employmentTypes: (json['employmentTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$JobFilterRequestToJson(JobFilterRequest instance) =>
    <String, dynamic>{
      'datePosted': instance.datePosted,
      'employmentTypes': instance.employmentTypes,
    };

DatePosted _$DatePostedFromJson(Map<String, dynamic> json) => DatePosted(
      from: json['from'] as String?,
      to: json['to'] as String?,
    );

Map<String, dynamic> _$DatePostedToJson(DatePosted instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
    };
