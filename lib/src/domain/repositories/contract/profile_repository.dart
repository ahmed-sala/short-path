import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/user_info/Certification_Entity.dart';
import 'package:short_path/src/domain/entities/user_info/Project_Entity.dart';
import 'package:short_path/src/domain/entities/user_info/additional_info_entity.dart';
import 'package:short_path/src/domain/entities/user_info/education_entity.dart';
import 'package:short_path/src/domain/entities/user_info/language_entity.dart';
import 'package:short_path/src/domain/entities/user_info/profile_entity.dart';
import 'package:short_path/src/domain/entities/user_info/skill_entity.dart';
import 'package:short_path/src/domain/entities/user_info/work_experience_entity.dart';

abstract interface class ProfileRepository {
  Future<ApiResult<ProfileEntity?>> getProfile();
  Future<ApiResult<SkillEntity?>> getSkills();

  Future<ApiResult<List<LanguageEntity>?>> getLanguages();
  Future<ApiResult<List<WorkExperienceEntity>?>> getWorkExperiences();
  Future<ApiResult<EducationEntity?>> getEducation();
  Future<ApiResult<CertificationsEntity?>> saveCertification();
  Future<ApiResult<ProjectsEntity?>> saveProjects();
  Future<ApiResult<AdditionalInfoEntity?>> saveAdditionalInfo();
}
