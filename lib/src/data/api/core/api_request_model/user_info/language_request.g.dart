// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageRequest _$LanguageRequestFromJson(Map<String, dynamic> json) =>
    LanguageRequest(
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => Languages.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LanguageRequestToJson(LanguageRequest instance) =>
    <String, dynamic>{
      'languages': instance.languages,
    };

Languages _$LanguagesFromJson(Map<String, dynamic> json) => Languages(
      language: json['language'] as String?,
      proficiency: json['proficiency'] as String?,
      validLanguage: json['validLanguage'] as bool?,
    );

Map<String, dynamic> _$LanguagesToJson(Languages instance) => <String, dynamic>{
      'language': instance.language,
      'proficiency': instance.proficiency,
      'validLanguage': instance.validLanguage,
    };
