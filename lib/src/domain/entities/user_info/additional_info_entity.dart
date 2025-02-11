class AdditionalInfoEntity {
  final String? hobbiesAndInterests;
  final String? publications;
  final String? awardsAndHonors;
  final VolunteerWork? volunteerWork;

  AdditionalInfoEntity({
    this.hobbiesAndInterests,
    this.publications,
    this.awardsAndHonors,
    this.volunteerWork,
  });
}

class VolunteerWork {
  final String description;
  final String month;
  final int year;

  VolunteerWork({
    required this.description,
    required this.month,
    required this.year,
  });
}