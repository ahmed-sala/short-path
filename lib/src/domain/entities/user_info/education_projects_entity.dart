import 'package:short_path/src/data/dto_models/user_info/EducationDto.dart';

class EducationProjectsEntity {
  final String? projectName;
  final String? projectDescription;
  final String? projectLink;
  final List<String>? toolsTechnologies; // Correct field name

  EducationProjectsEntity({
    this.projectName,
    this.projectDescription,
    this.projectLink,
    this.toolsTechnologies, // Correct field name
  });

  ProjectsDto toDto() {
    return ProjectsDto(
      projectName: projectName,
      projectDescription: projectDescription,
      projectLink: projectLink,
      toolsTechnologiesUsed: toolsTechnologies, // Map to DTO field
    );
  }
}
