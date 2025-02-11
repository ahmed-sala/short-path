import 'package:json_annotation/json_annotation.dart';

part 'additional_infromation_request.g.dart';

@JsonSerializable()
class AdditionalInfromationRequest {
  @JsonKey(name: "additionalInformation")
  final AdditionalInformation? additionalInformation;

  AdditionalInfromationRequest({
    this.additionalInformation,
  });

  factory AdditionalInfromationRequest.fromJson(Map<String, dynamic> json) {
    return _$AdditionalInfromationRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AdditionalInfromationRequestToJson(this);
  }
}

@JsonSerializable()
class AdditionalInformation {
  @JsonKey(name: "hobbiesAndInterests")
  final List<String>? hobbiesAndInterests;
  @JsonKey(name: "publications")
  final List<String>? publications;
  @JsonKey(name: "awardsAndHonors")
  final List<String>? awardsAndHonors;
  @JsonKey(name: "volunteerWork")
  final List<VolunteerWork>? volunteerWork;

  AdditionalInformation({
    this.hobbiesAndInterests,
    this.publications,
    this.awardsAndHonors,
    this.volunteerWork,
  });

  factory AdditionalInformation.fromJson(Map<String, dynamic> json) {
    return _$AdditionalInformationFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AdditionalInformationToJson(this);
  }
}

@JsonSerializable()
class VolunteerWork {
  @JsonKey(name: "organizationName")
  final String? organizationName;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "duration")
  final DurationRequest? duration;
  @JsonKey(name: "description")
  final String? description;

  VolunteerWork({
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
}

@JsonSerializable()
class DurationRequest {
  @JsonKey(name: "years")
  final int? years;
  @JsonKey(name: "months")
  final int? months;

  DurationRequest({
    this.years,
    this.months,
  });

  factory DurationRequest.fromJson(Map<String, dynamic> json) {
    return _$DurationRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DurationRequestToJson(this);
  }
}
