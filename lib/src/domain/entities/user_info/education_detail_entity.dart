import 'package:short_path/src/domain/entities/user_info/education_projects_entity.dart';

class EducationDetailEntity {
  final String? degreeCertification;
  final String? institutionName;
  final String? location;
  final String? graduationDate;
  final List<EducationProjectsEntity>? projects;

  EducationDetailEntity({
    this.degreeCertification,
    this.institutionName,
    this.location,
    this.graduationDate,
    this.projects,
  });
}
