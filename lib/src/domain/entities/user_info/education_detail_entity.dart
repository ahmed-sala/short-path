import 'package:short_path/src/data/dto_models/user_info/EducationDto.dart';
import 'package:short_path/src/domain/entities/user_info/education_projects_entity.dart';

class EducationDetailEntity {
  final String? degreeCertification;
  final String? institutionName;
  final String? location;
  final DateTime? graduationDate;
  final List<EducationProjectsEntity> projects;

  EducationDetailEntity({
    this.degreeCertification,
    this.institutionName,
    this.location,
    this.graduationDate,
    required this.projects,
  });

  EducationsDto toDto() {
    return EducationsDto(
      degreeCertification: degreeCertification,
      institutionName: institutionName,
      location: location,
      graduationDate: graduationDate,
      projects: projects.map((e) => e.toDto()).toList(),
    );
  }
}
