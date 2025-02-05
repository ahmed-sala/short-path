import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'education_request.g.dart';

@JsonSerializable()
class EducationRequest {
  @JsonKey(name: "educations")
  final List<Educations>? educations;

  EducationRequest({
    this.educations,
  });

  factory EducationRequest.fromJson(Map<String, dynamic> json) =>
      _$EducationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EducationRequestToJson(this);
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
  @LocalDateConverter()
  final DateTime? graduationDate;

  @JsonKey(name: "projects")
  final List<Projects>? projects;

  Educations({
    this.degreeCertification,
    this.institutionName,
    this.location,
    this.graduationDate,
    this.projects,
  });

  factory Educations.fromJson(Map<String, dynamic> json) =>
      _$EducationsFromJson(json);

  Map<String, dynamic> toJson() => _$EducationsToJson(this);
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

  factory Projects.fromJson(Map<String, dynamic> json) =>
      _$ProjectsFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectsToJson(this);
}

/// **Custom DateTime Converter**
/// Ensures `graduationDate` is always serialized as `"yyyy-MM-dd"`
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
