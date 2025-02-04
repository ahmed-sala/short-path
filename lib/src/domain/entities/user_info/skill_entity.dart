import 'package:short_path/src/data/dto_models/user_info/skills_dto.dart';
import 'package:short_path/src/domain/entities/user_info/tech_skill_entity.dart';

class SkillEntity {
  final List<TechnicalSkillEntity> technicalSkills;
  final List<String> softSkills;
  final List<String> industrySpecificSkills;

  SkillEntity({
    required this.technicalSkills,
    required this.softSkills,
    required this.industrySpecificSkills,
  });

  SkillsDto toSkillsDto() {
    return SkillsDto(
      technicalSkills: technicalSkills.map((e) => e.toTechDto()).toList(),
      softSkills: softSkills,
      industrySpecificSkills: industrySpecificSkills,
    );
  }
}
