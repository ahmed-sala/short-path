// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectResponse _$ProjectResponseFromJson(Map<String, dynamic> json) =>
    ProjectResponse(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      projectTitle: json['projectTitle'] as String?,
      role: json['role'] as String?,
      description: json['description'] as String?,
      projectLink: json['projectLink'] as String?,
      technologiesUsed: (json['technologiesUsed'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProjectResponseToJson(ProjectResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'projectTitle': instance.projectTitle,
      'role': instance.role,
      'description': instance.description,
      'projectLink': instance.projectLink,
      'technologiesUsed': instance.technologiesUsed,
    };
