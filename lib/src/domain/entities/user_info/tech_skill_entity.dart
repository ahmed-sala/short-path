import 'package:short_path/src/data/dto_models/user_info/skills_dto.dart';

class TechnicalSkillEntity {
  final String? skill;
  final String? proficiency;

  TechnicalSkillEntity({
    required this.skill,
    required this.proficiency,
  });

  TechnicalSkillsDto toTechDto() {
    return TechnicalSkillsDto(
      skill: skill!,
      proficiency: proficiency!,
    );
  }
}
