import 'package:short_path/src/data/dto_models/user_info/Additional_info_dto.dart';

class AdditionalInfoEntity {
  final List<String>? hobbiesAndInterests;
  final List<String>? publications;
  final List<String>? awardsAndHonors;
  final List<VolunteerWorkEntity>? volunteerWork;

  AdditionalInfoEntity({
    this.hobbiesAndInterests,
    this.publications,
    this.awardsAndHonors,
    this.volunteerWork,
  });
  AdditionalInfoDto toDto() {
    return AdditionalInfoDto(
        additionalInformation: AdditionalInformationDto(
      hobbiesAndInterests: hobbiesAndInterests,
      publications: publications,
      awardsAndHonors: awardsAndHonors,
      volunteerWork: volunteerWork?.map((e) => e.toDto()).toList(),
    ));
  }
}

class VolunteerWorkEntity {
  final String description;
  final int month;
  final int year;

  VolunteerWorkEntity({
    required this.description,
    required this.month,
    required this.year,
  });
  VolunteerWorkDto toDto() {
    return VolunteerWorkDto(
        description: description,
        duration: DurationDto(years: year, months: month));
  }
}
