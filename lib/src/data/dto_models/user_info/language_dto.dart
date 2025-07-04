import 'package:short_path/src/data/api/core/api_request_model/user_info/language_request.dart';
import 'package:short_path/src/domain/entities/user_info/language_entity.dart';

class LanguagesDto {
  final List<LanguageDto> languages;

  LanguagesDto({
    required this.languages,
  });

  LanguageRequest toLanguagesRequest() {
    return LanguageRequest(
      languages: languages.map((e) => e.toLanguages()).toList(),
    );
  }
}

class LanguageDto {
  final String language;
  final String proficiency;

  LanguageDto({
    required this.language,
    required this.proficiency,
  });
  Languages toLanguages() {
    return Languages(
      language: language,
      proficiency: proficiency,
    );
  }

  LanguageEntity toDomainEntity() {
    return LanguageEntity(
      language: language,
      level: proficiency,
    );
  }
}
