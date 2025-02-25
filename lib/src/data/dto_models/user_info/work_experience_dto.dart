import 'package:short_path/src/data/api/core/api_request_model/user_info/work_experience_request.dart';

class WorkExperienceDto {
  final String jobTitle;
  final String companyName;
  final String companyField;
  final String jobType;
  final String jobLocation;
  final DateTime startDate;
  final DateTime ? endDate;
  final String summary;
  final List<String> toolsTechnologiesUsed;

  WorkExperienceDto({
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

  WorkExperiences toWorkExperiences() {
    return WorkExperiences(
      jobTitle: jobTitle,
      companyName: companyName,
      companyField: companyField,
      jobType: jobType,
      jobLocation: jobLocation,
      startDate: startDate,
      endDate: endDate,
      summary: summary,
      toolsTechnologiesUsed: toolsTechnologiesUsed,
    );
  }
}

class WorkExperiencesDto {
  final List<WorkExperienceDto> workExperiences;

  WorkExperiencesDto({required this.workExperiences});

  WorkExperienceRequest toWorkExperienceRequest() {
    return WorkExperienceRequest(
      workExperiences:
          workExperiences.map((e) => e.toWorkExperiences()).toList(),
    );
  }
}
