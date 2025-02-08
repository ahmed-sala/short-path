import 'package:json_annotation/json_annotation.dart';

part 'project_request.g.dart';

@JsonSerializable()
class ProjectRequest {
  @JsonKey(name: "projects")
  final List<ProjectsReq>? projects;

  ProjectRequest({
    this.projects,
  });

  factory ProjectRequest.fromJson(Map<String, dynamic> json) {
    return _$ProjectRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProjectRequestToJson(this);
  }
}

@JsonSerializable()
class ProjectsReq {
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

  ProjectsReq({
    this.projectTitle,
    this.role,
    this.description,
    this.projectLink,
    this.technologiesUsed,
  });

  factory ProjectsReq.fromJson(Map<String, dynamic> json) {
    return _$ProjectsReqFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProjectsReqToJson(this);
  }
}
