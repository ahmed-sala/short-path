import 'package:json_annotation/json_annotation.dart';
import 'package:short_path/src/domain/entities/user_info/work_experience_entity.dart';

part 'work_experience_request.g.dart';

@JsonSerializable()
class WorkExperienceRequest {
  @JsonKey(name: "workExperiences")
  final List<WorkExperiences>? workExperiences;

  WorkExperienceRequest ({
    this.workExperiences,
  });

  factory WorkExperienceRequest.fromJson(Map<String, dynamic> json) {
    return _$WorkExperienceRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$WorkExperienceRequestToJson(this);
  }

  factory WorkExperienceRequest.fromDomainDto(List<WorkExperienceEntity> workExperiences) {
    return WorkExperienceRequest(
      workExperiences: workExperiences.map((e) => WorkExperiences.fromDomainEntity(e)).toList(),
    );
  }
}

@JsonSerializable()
class WorkExperiences {
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
  final String? startDate;
  @JsonKey(name: "endDate")
  final String? endDate;
  @JsonKey(name: "summary")
  final String? summary;
  @JsonKey(name: "toolsTechnologiesUsed")
  final List<String>? toolsTechnologiesUsed;

  WorkExperiences ({
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

  factory WorkExperiences.fromJson(Map<String, dynamic> json) {
    return _$WorkExperiencesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$WorkExperiencesToJson(this);
  }

  factory WorkExperiences.fromDomainEntity(WorkExperienceEntity workExperience) {
    return WorkExperiences(
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
}


