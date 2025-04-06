// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skills_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillsResponse _$SkillsResponseFromJson(Map<String, dynamic> json) =>
    SkillsResponse(
      userId: (json['userId'] as num?)?.toInt(),
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

Map<String, dynamic> _$SkillsResponseToJson(SkillsResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
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
