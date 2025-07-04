// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillRequest _$SkillRequestFromJson(Map<String, dynamic> json) => SkillRequest(
      skills: json['skills'] == null
          ? null
          : Skills.fromJson(json['skills'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SkillRequestToJson(SkillRequest instance) =>
    <String, dynamic>{
      'skills': instance.skills,
    };

Skills _$SkillsFromJson(Map<String, dynamic> json) => Skills(
      technicalSkills: (json['technicalSkills'] as List<dynamic>?)
          ?.map((e) => TechnicalSkills.fromJson(e as Map<String, dynamic>))
          .toList(),
      softSkills: (json['softSkills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      industrySpecificSkills: (json['industrySpecificSkills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SkillsToJson(Skills instance) => <String, dynamic>{
      'technicalSkills': instance.technicalSkills,
      'softSkills': instance.softSkills,
      'industrySpecificSkills': instance.industrySpecificSkills,
    };

TechnicalSkills _$TechnicalSkillsFromJson(Map<String, dynamic> json) =>
    TechnicalSkills(
      skill: json['skill'] as String?,
      proficiency: json['proficiency'] as String?,
    );

Map<String, dynamic> _$TechnicalSkillsToJson(TechnicalSkills instance) =>
    <String, dynamic>{
      'skill': instance.skill,
      'proficiency': instance.proficiency,
    };
