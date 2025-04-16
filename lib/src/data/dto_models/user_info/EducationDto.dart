import 'package:short_path/src/data/api/core/api_request_model/user_info/education_request.dart';

import '../../../domain/entities/user_info/education_detail_entity.dart';
import '../../../domain/entities/user_info/education_projects_entity.dart';

class EducationDto {
  EducationDto({
    List<EducationsDto>? educations,
  }) {
    _educations = educations;
  }

  EducationDto.fromJson(dynamic json) {
    if (json['educations'] != null) {
      _educations = [];
      json['educations'].forEach((v) {
        _educations?.add(EducationsDto.fromJson(v));
      });
    }
  }
  List<EducationsDto>? _educations;

  List<EducationsDto>? get educations => _educations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_educations != null) {
      map['educations'] = _educations?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  EducationRequest toRequest() {
    return EducationRequest(
      educations: _educations?.map((e) => e.toRequest()).toList(),
    );
  }
}

class EducationsDto {
  EducationsDto({
    String? degreeCertification,
    String? institutionName,
    String? location,
    DateTime? graduationDate,
    List<ProjectsDto>? projects,
    String? fieldOfStudy,
  }) {
    _degreeCertification = degreeCertification;
    _institutionName = institutionName;
    _location = location;
    _graduationDate = graduationDate;
    _projects = projects;
    _fieldOfStudy = fieldOfStudy;
  }

  EducationsDto.fromJson(dynamic json) {
    _degreeCertification = json['degreeCertification'];
    _institutionName = json['institutionName'];
    _location = json['location'];
    _graduationDate = json['graduationDate'];
    if (json['projects'] != null) {
      _projects = [];
      json['projects'].forEach((v) {
        _projects?.add(ProjectsDto.fromJson(v));
      });
    }
  }
  String? _degreeCertification;
  String? _institutionName;
  String? _location;
  DateTime? _graduationDate;
  List<ProjectsDto>? _projects;
  String? _fieldOfStudy;

  String? get degreeCertification => _degreeCertification;
  String? get institutionName => _institutionName;
  String? get location => _location;
  DateTime? get graduationDate => _graduationDate;
  List<ProjectsDto>? get projects => _projects;
  String? get fieldOfStudy => _fieldOfStudy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['degreeCertification'] = _degreeCertification;
    map['institutionName'] = _institutionName;
    map['location'] = _location;
    map['graduationDate'] = _graduationDate;
    if (_projects != null) {
      map['projects'] = _projects?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  Educations toRequest() {
    return Educations(
      degreeCertification: _degreeCertification,
      institutionName: _institutionName,
      location: _location,
      graduationDate: _graduationDate,
      projects: _projects?.map((e) => e.toRequest()).toList(),
      fieldOfStudy: _fieldOfStudy,
    );
  }

  EducationDetailEntity toEntity() {
    return EducationDetailEntity(
      degreeCertification: _degreeCertification,
      institutionName: _institutionName,
      location: _location,
      graduationDate: _graduationDate,
      projects: _projects!.map((e) => e.toEntity()).toList(),
      fieldOfStudy: _fieldOfStudy,
    );
  }
}

class ProjectsDto {
  ProjectsDto({
    String? projectName,
    String? projectDescription,
    String? projectLink,
    List<String>? toolsTechnologiesUsed,
  }) {
    _projectName = projectName;
    _projectDescription = projectDescription;
    _projectLink = projectLink;
    _toolsTechnologiesUsed = toolsTechnologiesUsed;
  }

  ProjectsDto.fromJson(dynamic json) {
    _projectName = json['projectName'];
    _projectDescription = json['projectDescription'];
    _projectLink = json['projectLink'];
    _toolsTechnologiesUsed = json['toolsTechnologiesUsed'] != null
        ? json['toolsTechnologiesUsed'].cast<String>()
        : [];
  }
  String? _projectName;
  String? _projectDescription;
  String? _projectLink;
  List<String>? _toolsTechnologiesUsed;

  String? get projectName => _projectName;
  String? get projectDescription => _projectDescription;
  String? get projectLink => _projectLink;
  List<String>? get toolsTechnologiesUsed => _toolsTechnologiesUsed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['projectName'] = _projectName;
    map['projectDescription'] = _projectDescription;
    map['projectLink'] = _projectLink;
    map['toolsTechnologiesUsed'] = _toolsTechnologiesUsed;
    return map;
  }

  Projects toRequest() {
    return Projects(
      projectName: _projectName,
      projectDescription: _projectDescription,
      projectLink: _projectLink,
      toolsTechnologiesUsed: _toolsTechnologiesUsed,
    );
  }

  EducationProjectsEntity toEntity() {
    return EducationProjectsEntity(
      projectName: _projectName,
      projectDescription: _projectDescription,
      projectLink: _projectLink,
      toolsTechnologies: _toolsTechnologiesUsed ?? [],
    );
  }
}
