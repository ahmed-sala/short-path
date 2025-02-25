import 'package:short_path/src/data/dto_models/user_info/work_experience_dto.dart';

class WorkExperienceEntity {
  final String jobTitle;
  final String companyName;
  final String companyField;
  final String jobType;
  final String jobLocation;
  final DateTime startDate;
  final DateTime? endDate;
  final String summary;
  final List<String> toolsTechnologiesUsed;

  WorkExperienceEntity({
    required this.jobTitle,
    required this.companyName,
    required this.companyField,
    required this.jobType,
    required this.jobLocation,
    required this.startDate,
    required this.endDate,
    required this.summary,
    required this.toolsTechnologiesUsed,
  });

  WorkExperienceDto toWorkExperienceDto() {
    return WorkExperienceDto(
        jobTitle: jobTitle,
        companyName: companyName,
        companyField: companyField,
        jobType: jobType,
        jobLocation: jobLocation,
        startDate: startDate,
        endDate: endDate,
        summary: summary,
        toolsTechnologiesUsed: toolsTechnologiesUsed);
  }
}
