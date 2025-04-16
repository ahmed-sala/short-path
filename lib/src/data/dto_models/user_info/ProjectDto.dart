import 'package:short_path/src/data/api/core/api_request_model/user_info/project_request.dart';
import 'package:short_path/src/domain/entities/user_info/Project_Entity.dart';

class ProjectDto {
  ProjectDto({
    List<ProjectsMainDto>? projects,
  }) {
    _projects = projects;
  }

  ProjectDto.fromJson(dynamic json) {
    if (json['projects'] != null) {
      _projects = [];
      json['projects'].forEach((v) {
        _projects?.add(ProjectsMainDto.fromJson(v));
      });
    }
  }
  List<ProjectsMainDto>? _projects;

  List<ProjectsMainDto>? get projects => _projects;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_projects != null) {
      map['projects'] = _projects?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  ProjectRequest toRequest() {
    return ProjectRequest(
      projects: _projects?.map((e) => e.toRequest()).toList(),
    );
  }
}

class ProjectsMainDto {
  ProjectsMainDto({
    String? projectTitle,
    String? role,
    String? description,
    String? projectLink,
    List<String>? technologiesUsed,
  }) {
    _projectTitle = projectTitle;
    _role = role;
    _description = description;
    _projectLink = projectLink;
    _technologiesUsed = technologiesUsed;
  }

  ProjectsMainDto.fromJson(dynamic json) {
    _projectTitle = json['projectTitle'];
    _role = json['role'];
    _description = json['description'];
    _projectLink = json['projectLink'];
    _technologiesUsed = json['technologiesUsed'] != null
        ? json['technologiesUsed'].cast<String>()
        : [];
  }
  String? _projectTitle;
  String? _role;
  String? _description;
  String? _projectLink;
  List<String>? _technologiesUsed;

  String? get projectTitle => _projectTitle;
  String? get role => _role;
  String? get description => _description;
  String? get projectLink => _projectLink;
  List<String>? get technologiesUsed => _technologiesUsed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['projectTitle'] = _projectTitle;
    map['role'] = _role;
    map['description'] = _description;
    map['projectLink'] = _projectLink;
    map['technologiesUsed'] = _technologiesUsed;
    return map;
  }

  ProjectsReq toRequest() {
    return ProjectsReq(
      projectTitle: _projectTitle,
      role: _role,
      description: _description,
      projectLink: _projectLink,
      technologiesUsed: _technologiesUsed,
    );
  }

  ProjectEntity toEntity() {
    return ProjectEntity(
      projectTitle: _projectTitle ?? '',
      role: _role ?? '',
      description: _description ?? '',
      projectLink: _projectLink ?? '',
      technologiesUsed: _technologiesUsed ?? [],
    );
  }
}
