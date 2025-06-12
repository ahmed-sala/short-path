// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extract_skills_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtractedSkillsDto _$ExtractedSkillsDtoFromJson(Map<String, dynamic> json) =>
    ExtractedSkillsDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExtractedSkillsDtoToJson(ExtractedSkillsDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      skill: json['skill'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      skillContext: json['skill_context'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'skill': instance.skill,
      'rating': instance.rating,
      'skill_context': instance.skillContext,
    };
