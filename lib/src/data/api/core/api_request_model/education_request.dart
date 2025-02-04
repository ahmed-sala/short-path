import 'package:json_annotation/json_annotation.dart';

part 'education_request.g.dart';

@JsonSerializable()
class EducationRequest {
  @JsonKey(name: "educations")
  final List<Educations>? educations;

  EducationRequest({
    this.educations,
  });

  factory EducationRequest.fromJson(Map<String, dynamic> json) {
    return _$EducationRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EducationRequestToJson(this);
  }
}

@JsonSerializable()
class Educations {
  @JsonKey(name: "degreeCertification")
  final String? degreeCertification;
  @JsonKey(name: "institutionName")
  final String? institutionName;
  @JsonKey(name: "location")
  final String? location;
  @JsonKey(name: "graduationDate")
  final String? graduationDate;
  @JsonKey(name: "projects")
  final List<Projects>? projects;

  Educations({
    this.degreeCertification,
    this.institutionName,
    this.location,
    this.graduationDate,
    this.projects,
  });

  factory Educations.fromJson(Map<String, dynamic> json) {
    return _$EducationsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EducationsToJson(this);
  }
}

@JsonSerializable()
class Projects {
  @JsonKey(name: "projectName")
  final String? projectName;
  @JsonKey(name: "projectDescription")
  final String? projectDescription;
  @JsonKey(name: "projectLink")
  final String? projectLink;
  @JsonKey(name: "toolsTechnologiesUsed")
  final List<String>? toolsTechnologiesUsed;

  Projects({
    this.projectName,
    this.projectDescription,
    this.projectLink,
    this.toolsTechnologiesUsed,
  });

  factory Projects.fromJson(Map<String, dynamic> json) {
    return _$ProjectsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProjectsToJson(this);
  }
}
