import '../../api/core/api_request_model/user_info/work_experience_request.dart';

class WorkExperience {
  final String jobTitle;
  final String companyName;
  final String companyField;
  final String jobType;
  final String jobLocation;
  final String startDate;
  final String endDate;
  final String summary;
  final List<String> toolsTechnologiesUsed;

  WorkExperience({
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
}

class WorkExperienceDto {
  final List<WorkExperience> workExperiences;

  WorkExperienceDto({required this.workExperiences});

  WorkExperienceRequest toWorkExperienceRequest() {
    return WorkExperienceRequest(
      workExperiences: workExperiences
          .map((experience) => WorkExperiences(
        jobTitle: experience.jobTitle,
        companyName: experience.companyName,
        companyField: experience.companyField,
        jobType: experience.jobType,
        jobLocation: experience.jobLocation,
        startDate: experience.startDate,
        endDate: experience.endDate,
        summary: experience.summary,
        toolsTechnologiesUsed: experience.toolsTechnologiesUsed,
      ))
          .toList(),
    );
  }
}

