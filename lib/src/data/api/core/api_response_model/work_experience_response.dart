import 'package:json_annotation/json_annotation.dart';
import 'package:short_path/src/data/dto_models/user_info/work_experience_dto.dart';

import '../../../../domain/entities/user_info/work_experience_entity.dart';

part 'work_experience_response.g.dart';

@JsonSerializable()
class WorkExperienceResponse {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "userId")
  final int? userId;
  @JsonKey(name: "jobTitle")
  final String? jobTitle;
  @JsonKey(name: "companyName")
  final String? companyName;
  @JsonKey(name: "companyField")
  final String? companyField;
  @JsonKey(name: "jobType")
  final String? jobType;
  @JsonKey(name: "jobLocation")
  final String? jobLocation;
  @JsonKey(name: "startDate")
  @LocalDateConverter()
  final DateTime? startDate;
  @JsonKey(name: "endDate")
  @LocalDateConverter()
  final DateTime? endDate;
  @JsonKey(name: "summary")
  final String? summary;
  @JsonKey(name: "toolsTechnologiesUsed")
  final List<String>? toolsTechnologiesUsed;

  WorkExperienceResponse({
    this.id,
    this.userId,
    this.jobTitle,
    this.companyName,
    this.companyField,
    this.jobType,
    this.jobLocation,
    this.startDate,
    this.endDate,
    this.summary,
    this.toolsTechnologiesUsed,
  });

  factory WorkExperienceResponse.fromJson(Map<String, dynamic> json) {
    return _$WorkExperienceResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$WorkExperienceResponseToJson(this);
  }

  factory WorkExperienceResponse.fromDomainEntity(
      WorkExperienceEntity workExperience) {
    return WorkExperienceResponse(
      jobTitle: workExperience.jobTitle,
      companyName: workExperience.companyName,
      companyField: workExperience.companyField,
      jobType: workExperience.jobType,
      jobLocation: workExperience.jobLocation,
      startDate: workExperience.startDate,
      endDate: workExperience.endDate,
      summary: workExperience.summary,
      toolsTechnologiesUsed: workExperience.toolsTechnologiesUsed,
    );
  }

  WorkExperienceDto toDto() {
    return WorkExperienceDto(
      jobTitle: jobTitle ?? '',
      companyName: companyName ?? '',
      companyField: companyField ?? '',
      jobType: jobType ?? '',
      jobLocation: jobLocation ?? '',
      startDate: startDate ?? DateTime.now(),
      endDate: endDate ?? DateTime.now(),
      summary: summary ?? '',
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
