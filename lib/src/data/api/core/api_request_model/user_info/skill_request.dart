import 'package:json_annotation/json_annotation.dart';

part 'skill_request.g.dart';

@JsonSerializable()
class SkillRequest {
  @JsonKey(name: "technicalSkills")
  final List<TechnicalSkills>? technicalSkills;
  @JsonKey(name: "softSkills")
  final List<String>? softSkills;
  @JsonKey(name: "industrySpecificSkills")
  final List<String>? industrySpecificSkills;

  SkillRequest({
    this.technicalSkills,
    this.softSkills,
    this.industrySpecificSkills,
  });

  factory SkillRequest.fromJson(Map<String, dynamic> json) {
    return _$SkillRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SkillRequestToJson(this);
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
