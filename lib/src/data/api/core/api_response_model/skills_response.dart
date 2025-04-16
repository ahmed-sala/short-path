import 'package:json_annotation/json_annotation.dart';
import 'package:short_path/src/data/dto_models/user_info/skills_dto.dart';

part 'skills_response.g.dart';

@JsonSerializable()
class SkillsResponse {
  @JsonKey(name: "userId")
  final int? userId;
  @JsonKey(name: "technicalSkills")
  final List<TechnicalSkills>? technicalSkills;
  @JsonKey(name: "softSkills")
  final List<String>? softSkills;
  @JsonKey(name: "industrySpecificSkills")
  final List<String>? industrySpecificSkills;

  SkillsResponse({
    this.userId,
    this.technicalSkills,
    this.softSkills,
    this.industrySpecificSkills,
  });

  factory SkillsResponse.fromJson(Map<String, dynamic> json) {
    return _$SkillsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SkillsResponseToJson(this);
  }

  SkillsDto toDto() {
    return SkillsDto(
      technicalSkills: technicalSkills?.map((e) => e.toDto()).toList() ?? [],
      softSkills: softSkills ?? [],
      industrySpecificSkills: industrySpecificSkills ?? [],
    );
  }
}

@JsonSerializable()
class TechnicalSkills {
  @JsonKey(name: "skill")
  final String? skill;
  @JsonKey(name: "proficiency")
  final String? proficiency;

  TechnicalSkills({
    this.skill,
    this.proficiency,
  });

  factory TechnicalSkills.fromJson(Map<String, dynamic> json) {
    return _$TechnicalSkillsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TechnicalSkillsToJson(this);
  }

  TechnicalSkillsDto toDto() {
    return TechnicalSkillsDto(
      skill: skill ?? '',
      proficiency: proficiency ?? '',
    );
  }
}
