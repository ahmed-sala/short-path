import 'package:json_annotation/json_annotation.dart';

part 'extract_skills_dto.g.dart';

@JsonSerializable()
class ExtractedSkillsDto {
  @JsonKey(name: "data")
  final List<Data>? data;

  ExtractedSkillsDto ({
    this.data,
  });

  factory ExtractedSkillsDto.fromJson(Map<String, dynamic> json) {
    return _$ExtractedSkillsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExtractedSkillsDtoToJson(this);
  }
}

@JsonSerializable()
class Data {
  @JsonKey(name: "skill")
  final String? skill;
  @JsonKey(name: "rating")
  final int? rating;
  @JsonKey(name: "skill_context")
  final String? skillContext;

  Data ({
    this.skill,
    this.rating,
    this.skillContext,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
  }
}


