import 'package:json_annotation/json_annotation.dart';
import 'package:short_path/src/domain/entities/user_info/language_entity.dart';

part 'language_request.g.dart';

@JsonSerializable()
class LanguageRequest {
  @JsonKey(name: "languages")
  final List<Languages>? languages;

  LanguageRequest({
    this.languages,
  });

  factory LanguageRequest.fromJson(Map<String, dynamic> json) {
    return _$LanguageRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LanguageRequestToJson(this);
  }

  factory LanguageRequest.fromDomainDto(List<LanguageEntity> languages) {
    return LanguageRequest(
      languages: languages.map((e) => Languages.fromDomainEntity(e)).toList(),
    );
  }
}

@JsonSerializable()
class Languages {
  @JsonKey(name: "language")
  final String? language;
  @JsonKey(name: "proficiency")
  final String? proficiency;
  @JsonKey(name: "validLanguage")
  final bool? validLanguage;

  Languages({
    this.language,
    this.proficiency,
    this.validLanguage,
  });

  factory Languages.fromJson(Map<String, dynamic> json) {
    return _$LanguagesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LanguagesToJson(this);
  }

  factory Languages.fromDomainEntity(LanguageEntity language) {
    return Languages(
      language: language.language,
      proficiency: language.level,
    );
  }
}
