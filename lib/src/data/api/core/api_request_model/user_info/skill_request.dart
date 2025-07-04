import 'package:json_annotation/json_annotation.dart';

part 'skill_request.g.dart';

@JsonSerializable()
class SkillRequest {
  @JsonKey(name: "skills")
  final Skills? skills;

  SkillRequest({
    this.skills,
  });

  factory SkillRequest.fromJson(Map<String, dynamic> json) {
    return _$SkillRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SkillRequestToJson(this);
  }
}

@JsonSerializable()
class Skills {
  @JsonKey(name: "technicalSkills")
  final List<TechnicalSkills>? technicalSkills;
  @JsonKey(name: "softSkills")
  final List<String>? softSkills;
  @JsonKey(name: "industrySpecificSkills")
  final List<String>? industrySpecificSkills;

  Skills({
    this.technicalSkills,
    this.softSkills,
    this.industrySpecificSkills,
  });

  factory Skills.fromJson(Map<String, dynamic> json) {
    return _$SkillsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SkillsToJson(this);
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
}
