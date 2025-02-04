import 'package:short_path/src/data/dto_models/user_info/language_dto.dart';

class LanguageEntity {
  final String language;
  final String level;

  LanguageEntity({
    required this.language,
    required this.level,
  });

  LanguageDto toLanguageDto() {
    return LanguageDto(
      language: language,
      proficiency: level,
    );
  }
}
