import '../../../data/dto_models/user_info/EducationDto.dart';

class EducationProjectsEntity {
  final String? projectName;
  final String? projectDescription;
  final String? projectLink;
  final List<String>? toolsTechnologiesUsed;
  EducationProjectsEntity({
    this.projectName,
    this.projectDescription,
    this.projectLink,
    this.toolsTechnologiesUsed,
  });

  ProjectsDto toDto() {
    return ProjectsDto(
      projectName: projectName,
      projectDescription: projectDescription,
      projectLink: projectLink,
      toolsTechnologiesUsed: toolsTechnologiesUsed,
    );
  }
}
