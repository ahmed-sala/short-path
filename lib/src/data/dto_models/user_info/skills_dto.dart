import 'package:short_path/src/data/api/core/api_request_model/user_info/skill_request.dart';

class SkillsDto {
  final List<TechnicalSkillsDto> technicalSkills;
  final List<String> softSkills;
  final List<String> industrySpecificSkills;

  SkillsDto({
    required this.technicalSkills,
    required this.softSkills,
    required this.industrySpecificSkills,
  });
  SkillRequest toSkillsRequest() {
    return SkillRequest(
      skills: Skills(
        technicalSkills: technicalSkills.map((e) => e.toTechRequest()).toList(),
        softSkills: softSkills,
        industrySpecificSkills: industrySpecificSkills,
      ),
    );
  }
}

class TechnicalSkillsDto {
  final String skill;
  final String proficiency;

  TechnicalSkillsDto({
    required this.skill,
    required this.proficiency,
  });

  TechnicalSkills toTechRequest() {
    return TechnicalSkills(
      skill: skill,
      proficiency: proficiency,
    );
  }
}
