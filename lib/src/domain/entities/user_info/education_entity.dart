import 'package:short_path/src/data/dto_models/user_info/EducationDto.dart';
import 'package:short_path/src/domain/entities/user_info/education_detail_entity.dart';

class EducationEntity {
  final List<EducationDetailEntity>? educationDetails;

  EducationEntity({
    this.educationDetails,
  });
  EducationDto toDto() {
    return EducationDto(
      educations: educationDetails?.map((e) => e.toDto()).toList(),
    );
  }
}
