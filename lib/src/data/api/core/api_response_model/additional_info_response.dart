import 'package:json_annotation/json_annotation.dart';
import 'package:short_path/src/data/dto_models/user_info/Additional_info_dto.dart';

import '../../../dto_models/user_info/EducationDto.dart';

part 'additional_info_response.g.dart';

@JsonSerializable()
class AdditionalInfoResponse {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "volunteerWork")
  final List<VolunteerWork>? volunteerWork;
  @JsonKey(name: "hobbiesAndInterests")
  final List<String>? hobbiesAndInterests;
  @JsonKey(name: "publications")
  final List<String>? publications;
  @JsonKey(name: "awardsAndHonors")
  final List<String>? awardsAndHonors;

  AdditionalInfoResponse({
    this.id,
    this.volunteerWork,
    this.hobbiesAndInterests,
    this.publications,
    this.awardsAndHonors,
  });

  factory AdditionalInfoResponse.fromJson(Map<String, dynamic> json) {
    return _$AdditionalInfoResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AdditionalInfoResponseToJson(this);
  }

  AdditionalInformationDto toDto() {
    return AdditionalInformationDto(
      volunteerWork: volunteerWork!.map((e) => e.toDto()).toList(),
      hobbiesAndInterests: hobbiesAndInterests,
      publications: publications,
      awardsAndHonors: awardsAndHonors,
    );
  }
}

@JsonSerializable()
class VolunteerWork {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "organizationName")
  final String? organizationName;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "duration")
  final String? duration;
  @JsonKey(name: "description")
  final String? description;

  VolunteerWork({
    this.id,
    this.organizationName,
    this.role,
    this.duration,
    this.description,
  });

  factory VolunteerWork.fromJson(Map<String, dynamic> json) {
    return _$VolunteerWorkFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VolunteerWorkToJson(this);
  }

  VolunteerWorkDto toDto() {
    return VolunteerWorkDto(
      organizationName: organizationName,
      role: role,
      duration: DurationDto(years: int.parse(duration!)),
      description: description,
    );
  }

  ProjectsDto toDto() {
    return ProjectsDto(
      projectTitle: projectTitle,
      role: role,
      description: description,
      projectLink: projectLink,
      technologiesUsed: technologiesUsed,
    );
  }
}
