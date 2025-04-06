// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageResponse _$LanguageResponseFromJson(Map<String, dynamic> json) =>
    LanguageResponse(
      id: (json['id'] as num?)?.toInt(),
      language: json['language'] as String?,
      proficiency: json['proficiency'] as String?,
    );

Map<String, dynamic> _$LanguageResponseToJson(LanguageResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'language': instance.language,
      'proficiency': instance.proficiency,
    };
