import 'package:json_annotation/json_annotation.dart';
import 'package:short_path/src/data/dto_models/user_info/ProjectDto.dart';

part 'project_response.g.dart';

@JsonSerializable()
class ProjectResponse {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "userId")
  final int? userId;
  @JsonKey(name: "projectTitle")
  final String? projectTitle;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "projectLink")
  final String? projectLink;
  @JsonKey(name: "technologiesUsed")
  final List<String>? technologiesUsed;

  ProjectResponse({
    this.id,
    this.userId,
    this.projectTitle,
    this.role,
    this.description,
    this.projectLink,
    this.technologiesUsed,
  });

  factory ProjectResponse.fromJson(Map<String, dynamic> json) {
    return _$ProjectResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProjectResponseToJson(this);
  }

  ProjectsMainDto toDto() {
    return ProjectsMainDto(
      projectTitle: projectTitle??'',
      role: role??'',
      description: description??'',
      projectLink: projectLink??'',
      technologiesUsed: technologiesUsed??[],
    );
}
