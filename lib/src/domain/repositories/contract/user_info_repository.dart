import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/user_info/language_entity.dart';
import 'package:short_path/src/domain/entities/user_info/profile_entity.dart';
import 'package:short_path/src/domain/entities/user_info/skill_entity.dart';

import '../../entities/user_info/Certification_Entity.dart';
import '../../entities/user_info/Project_Entity.dart';
import '../../entities/user_info/additional_info_entity.dart';
import '../../entities/user_info/education_entity.dart';
import '../../entities/user_info/work_experience_entity.dart';

abstract interface class UserInfoRepository {
  Future<ApiResult<void>> saveProfile(ProfileEntity profileDto);
  Future<ApiResult<void>> saveSkills(SkillEntity skillEntity);

  Future<ApiResult<void>> saveLanguages(List<LanguageEntity> languages);
  Future<ApiResult<void>> saveWorkExperiences(
      List<WorkExperienceEntity> workExperiences);
  Future<ApiResult<void>> saveEducation(EducationEntity educationEntity);
  Future<ApiResult<void>> saveCertification(
      CertificationsEntity certificationEntity);
  Future<ApiResult<void>> saveProjects(ProjectsEntity projects);
  Future<ApiResult<void>> saveAdditionalInfo(
      AdditionalInfoEntity additionalInfo);
}
