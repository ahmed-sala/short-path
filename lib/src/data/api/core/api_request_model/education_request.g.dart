// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EducationRequest _$EducationRequestFromJson(Map<String, dynamic> json) =>
    EducationRequest(
      educations: (json['educations'] as List<dynamic>?)
          ?.map((e) => Educations.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EducationRequestToJson(EducationRequest instance) =>
    <String, dynamic>{
      'educations': instance.educations,
    };

Educations _$EducationsFromJson(Map<String, dynamic> json) => Educations(
      degreeCertification: json['degreeCertification'] as String?,
      institutionName: json['institutionName'] as String?,
      location: json['location'] as String?,
      graduationDate: json['graduationDate'] as String?,
      projects: (json['projects'] as List<dynamic>?)
          ?.map((e) => Projects.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EducationsToJson(Educations instance) =>
    <String, dynamic>{
      'degreeCertification': instance.degreeCertification,
      'institutionName': instance.institutionName,
      'location': instance.location,
      'graduationDate': instance.graduationDate,
      'projects': instance.projects,
    };

Projects _$ProjectsFromJson(Map<String, dynamic> json) => Projects(
      projectName: json['projectName'] as String?,
      projectDescription: json['projectDescription'] as String?,
      projectLink: json['projectLink'] as String?,
      toolsTechnologiesUsed: (json['toolsTechnologiesUsed'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProjectsToJson(Projects instance) => <String, dynamic>{
      'projectName': instance.projectName,
      'projectDescription': instance.projectDescription,
      'projectLink': instance.projectLink,
      'toolsTechnologiesUsed': instance.toolsTechnologiesUsed,
    };
