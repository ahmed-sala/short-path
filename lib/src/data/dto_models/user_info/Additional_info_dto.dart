import 'package:short_path/src/data/api/core/api_request_model/user_info/additional_infromation_request.dart';

import '../../../domain/entities/user_info/additional_info_entity.dart';

class AdditionalInfoDto {
  AdditionalInfoDto({
    AdditionalInformationDto? additionalInformation,
  }) {
    _additionalInformation = additionalInformation;
  }

  AdditionalInfoDto.fromJson(dynamic json) {
    _additionalInformation = json['additionalInformation'] != null
        ? AdditionalInformationDto.fromJson(json['additionalInformation'])
        : null;
  }
  AdditionalInformationDto? _additionalInformation;

  AdditionalInformationDto? get additionalInformation => _additionalInformation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_additionalInformation != null) {
      map['additionalInformation'] = _additionalInformation?.toJson();
    }
    return map;
  }

  AdditionalInfromationRequest toRequest() {
    return AdditionalInfromationRequest(
      additionalInformation: _additionalInformation?.toRequest(),
    );
  }
}

class AdditionalInformationDto {
  AdditionalInformationDto({
    List<String>? hobbiesAndInterests,
    List<String>? publications,
    List<String>? awardsAndHonors,
    List<VolunteerWorkDto>? volunteerWork,
  }) {
    _hobbiesAndInterests = hobbiesAndInterests;
    _publications = publications;
    _awardsAndHonors = awardsAndHonors;
    _volunteerWork = volunteerWork;
  }

  AdditionalInformationDto.fromJson(dynamic json) {
    _hobbiesAndInterests = json['hobbiesAndInterests'] != null
        ? json['hobbiesAndInterests'].cast<String>()
        : [];
    _publications =
        json['publications'] != null ? json['publications'].cast<String>() : [];
    _awardsAndHonors = json['awardsAndHonors'] != null
        ? json['awardsAndHonors'].cast<String>()
        : [];
    if (json['volunteerWork'] != null) {
      _volunteerWork = [];
      json['volunteerWork'].forEach((v) {
        _volunteerWork?.add(VolunteerWorkDto.fromJson(v));
      });
    }
  }
  List<String>? _hobbiesAndInterests;
  List<String>? _publications;
  List<String>? _awardsAndHonors;
  List<VolunteerWorkDto>? _volunteerWork;

  List<String>? get hobbiesAndInterests => _hobbiesAndInterests;
  List<String>? get publications => _publications;
  List<String>? get awardsAndHonors => _awardsAndHonors;
  List<VolunteerWorkDto>? get volunteerWork => _volunteerWork;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hobbiesAndInterests'] = _hobbiesAndInterests;
    map['publications'] = _publications;
    map['awardsAndHonors'] = _awardsAndHonors;
    if (_volunteerWork != null) {
      map['volunteerWork'] = _volunteerWork?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  AdditionalInformation toRequest() {
    return AdditionalInformation(
      hobbiesAndInterests: _hobbiesAndInterests,
      publications: _publications,
      awardsAndHonors: _awardsAndHonors,
      volunteerWork: _volunteerWork?.map((v) => v.toRequest()).toList(),
    );
  }

  AdditionalInfoEntity toEntity() {
    return AdditionalInfoEntity(
      hobbiesAndInterests: hobbiesAndInterests ?? [],
      publications: publications ?? [],
      awardsAndHonors: awardsAndHonors ?? [],
      volunteerWork: volunteerWork?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

class VolunteerWorkDto {
  VolunteerWorkDto({
    String? organizationName,
    String? role,
    DurationDto? duration,
    String? description,
  }) {
    _organizationName = organizationName;
    _role = role;
    _duration = duration;
    _description = description;
  }

  VolunteerWorkDto.fromJson(dynamic json) {
    _organizationName = json['organizationName'];
    _role = json['role'];
    _duration = json['duration'] != null
        ? DurationDto.fromJson(json['duration'])
        : null;
    _description = json['description'];
  }
  String? _organizationName;
  String? _role;
  DurationDto? _duration;
  String? _description;

  String? get organizationName => _organizationName;
  String? get role => _role;
  DurationDto? get duration => _duration;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['organizationName'] = _organizationName;
    map['role'] = _role;
    if (_duration != null) {
      map['duration'] = _duration?.toJson();
    }
    map['description'] = _description;
    return map;
  }

  VolunteerWork toRequest() {
    return VolunteerWork(
      organizationName: _organizationName,
      role: _role,
      duration: _duration?.toRequest(),
      description: _description,
    );
  }

  VolunteerWorkEntity toEntity() {
    return VolunteerWorkEntity(
      description: description ?? '',
      month: duration?._months ?? 0,
      year: duration?._years ?? 0,
    );
  }
}

class DurationDto {
  DurationDto({
    int? years,
    int? months,
  }) {
    _years = years;
    _months = months;
  }

  DurationDto.fromJson(dynamic json) {
    _years = json['years'];
    _months = json['months'];
  }
  int? _years;
  int? _months;

  int? get years => _years;
  int? get months => _months;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['years'] = _years;
    map['months'] = _months;
    return map;
  }

  DurationRequest toRequest() {
    return DurationRequest(
      years: _years,
      months: _months,
    );
  }
}
