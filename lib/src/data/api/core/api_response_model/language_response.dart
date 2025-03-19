import 'package:json_annotation/json_annotation.dart';
import 'package:short_path/src/data/dto_models/user_info/language_dto.dart';

import '../../../../domain/entities/user_info/language_entity.dart';

part 'language_response.g.dart';

@JsonSerializable()
class LanguageResponse {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "language")
  final String? language;
  @JsonKey(name: "proficiency")
  final String? proficiency;

  LanguageResponse({
    this.id,
    this.language,
    this.proficiency,
  });

  factory LanguageResponse.fromJson(Map<String, dynamic> json) {
    return _$LanguageResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LanguageResponseToJson(this);
  }

  factory LanguageResponse.fromDomainEntity(LanguageEntity language) {
    return LanguageResponse(
      language: language.language,
      proficiency: language.level,
    );
  }

  LanguageDto toDto() {
    return LanguageDto(
      language: language ?? '',
      proficiency: proficiency ?? '',
    );
  }
}
