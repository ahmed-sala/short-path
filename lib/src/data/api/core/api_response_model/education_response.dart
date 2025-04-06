import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:short_path/src/data/dto_models/user_info/EducationDto.dart';

part 'education_response.g.dart';

@JsonSerializable()
class EducationResponse {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "degreeCertification")
  final String? degreeCertification;
  @JsonKey(name: "institutionName")
  final String? institutionName;
  @JsonKey(name: "fieldOfStudy")
  final String? fieldOfStudy;
  @JsonKey(name: "location")
  final String? location;
  @JsonKey(name: "graduationDate")
  @LocalDateConverter()
  final DateTime? graduationDate;
  @JsonKey(name: "projects")
  final List<Projects>? projects;

  EducationResponse({
    this.id,
    this.degreeCertification,
    this.institutionName,
    this.fieldOfStudy,
    this.location,
    this.graduationDate,
    this.projects,
  });

  factory EducationResponse.fromJson(Map<String, dynamic> json) {
    return _$EducationResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EducationResponseToJson(this);
  }

  EducationsDto toDto() {
    return EducationsDto(
      degreeCertification: degreeCertification ?? '',
      institutionName: institutionName ?? '',
      fieldOfStudy: fieldOfStudy ?? '',
      location: location ?? '',
      graduationDate: graduationDate ?? DateTime.now(),
      projects: projects?.map((e) => e.toDto()).toList() ?? [],
    );
  }
}

@JsonSerializable()
class Projects {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "projectName")
  final String? projectName;
  @JsonKey(name: "projectDescription")
  final String? projectDescription;
  @JsonKey(name: "projectLink")
  final String? projectLink;
  @JsonKey(name: "toolsTechnologiesUsed")
  final List<String>? toolsTechnologiesUsed;

  Projects({
    this.id,
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

  ProjectsDto toDto() {
    return ProjectsDto(
      projectName: projectName ?? '',
      projectDescription: projectDescription ?? '',
      projectLink: projectLink ?? '',
      toolsTechnologiesUsed: toolsTechnologiesUsed ?? [],
    );
  }
}

class LocalDateConverter implements JsonConverter<DateTime?, String?> {
  const LocalDateConverter();

  @override
  DateTime? fromJson(String? json) {
    return json != null ? DateTime.parse(json) : null;
  }

  @override
  String? toJson(DateTime? date) {
    return date != null ? DateFormat("yyyy-MM-dd").format(date) : null;
  }
}
