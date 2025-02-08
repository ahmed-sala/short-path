// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectRequest _$ProjectRequestFromJson(Map<String, dynamic> json) =>
    ProjectRequest(
      projects: (json['projects'] as List<dynamic>?)
          ?.map((e) => ProjectsReq.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectRequestToJson(ProjectRequest instance) =>
    <String, dynamic>{
      'projects': instance.projects,
    };

ProjectsReq _$ProjectsReqFromJson(Map<String, dynamic> json) => ProjectsReq(
      projectTitle: json['projectTitle'] as String?,
      role: json['role'] as String?,
      description: json['description'] as String?,
      projectLink: json['projectLink'] as String?,
      technologiesUsed: (json['technologiesUsed'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProjectsReqToJson(ProjectsReq instance) =>
    <String, dynamic>{
      'projectTitle': instance.projectTitle,
      'role': instance.role,
      'description': instance.description,
      'projectLink': instance.projectLink,
      'technologiesUsed': instance.technologiesUsed,
    };
