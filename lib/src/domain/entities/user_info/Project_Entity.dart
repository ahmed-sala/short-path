import 'package:short_path/src/data/dto_models/user_info/ProjectDto.dart';

class ProjectsEntity {
  final List<ProjectEntity> projects;

  ProjectsEntity({
    required this.projects,
  });

  ProjectDto toDto() {
    return ProjectDto(
      projects: projects.map((e) => e.toDto()).toList(),
    );
  }
}

class ProjectEntity {
  final String projectTitle;
  final String role;
  final String description;
  final List<String> technologiesUsed;
  final String projectLink;

  ProjectEntity({
    required this.projectTitle,
    required this.role,
    required this.description,
    required this.technologiesUsed,
    required this.projectLink,
  });
  ProjectsMainDto toDto() {
    return ProjectsMainDto(
      projectTitle: projectTitle,
      role: role,
      description: description,
      projectLink: projectLink,
      technologiesUsed: technologiesUsed,
    );
  }
}
