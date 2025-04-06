// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EducationResponse _$EducationResponseFromJson(Map<String, dynamic> json) =>
    EducationResponse(
      id: (json['id'] as num?)?.toInt(),
      degreeCertification: json['degreeCertification'] as String?,
      institutionName: json['institutionName'] as String?,
      fieldOfStudy: json['fieldOfStudy'] as String?,
      location: json['location'] as String?,
      graduationDate: const LocalDateConverter()
          .fromJson(json['graduationDate'] as String?),
      projects: (json['projects'] as List<dynamic>?)
          ?.map((e) => Projects.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EducationResponseToJson(EducationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'degreeCertification': instance.degreeCertification,
      'institutionName': instance.institutionName,
      'fieldOfStudy': instance.fieldOfStudy,
      'location': instance.location,
      'graduationDate':
          const LocalDateConverter().toJson(instance.graduationDate),
      'projects': instance.projects,
    };

Projects _$ProjectsFromJson(Map<String, dynamic> json) => Projects(
      id: (json['id'] as num?)?.toInt(),
      projectName: json['projectName'] as String?,
      projectDescription: json['projectDescription'] as String?,
      projectLink: json['projectLink'] as String?,
      toolsTechnologiesUsed: (json['toolsTechnologiesUsed'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProjectsToJson(Projects instance) => <String, dynamic>{
      'id': instance.id,
      'projectName': instance.projectName,
      'projectDescription': instance.projectDescription,
      'projectLink': instance.projectLink,
      'toolsTechnologiesUsed': instance.toolsTechnologiesUsed,
    };
