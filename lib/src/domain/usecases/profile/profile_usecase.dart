import 'package:injectable/injectable.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';
import 'package:short_path/src/domain/entities/user_info/skill_entity.dart';
import 'package:short_path/src/domain/repositories/contract/auth_repository.dart';
import 'package:short_path/src/domain/repositories/contract/profile_repository.dart';

import '../../../../core/common/api/api_result.dart';
import '../../entities/user_info/Certification_Entity.dart';
import '../../entities/user_info/Project_Entity.dart';
import '../../entities/user_info/additional_info_entity.dart';
import '../../entities/user_info/education_entity.dart';
import '../../entities/user_info/language_entity.dart';
import '../../entities/user_info/profile_entity.dart';
import '../../entities/user_info/work_experience_entity.dart';

@injectable
class ProfileUsecase {
  ProfileRepository _profileRepository;
  AuthRepository _authRepository;
  ProfileUsecase(this._profileRepository, this._authRepository);

  Future<ApiResult<ProfileEntity?>> getProfile() async {
    return await _profileRepository.getProfile();
  }

  Future<ApiResult<SkillEntity?>> getSkills() async {
    return await _profileRepository.getSkills();
  }

  Future<ApiResult<List<LanguageEntity>?>> getLanguages() async {
    return await _profileRepository.getLanguages();
  }

  Future<ApiResult<List<WorkExperienceEntity>?>> getWorkExperiences() async {
    return await _profileRepository.getWorkExperiences();
  }

  Future<ApiResult<EducationEntity?>> getEducation() async {
    return await _profileRepository.getEducation();
  }

  Future<ApiResult<CertificationsEntity?>> getCertification() async {
    return await _profileRepository.getCertification();
  }

  Future<ApiResult<ProjectsEntity?>> getProjects() async {
    return await _profileRepository.getProjects();
  }

  Future<ApiResult<AdditionalInfoEntity?>> getAdditionalInfo() async {
    return await _profileRepository.getAdditionalInfo();
  }

  Future<ApiResult<AppUser?>> getUser() {
    return _authRepository.getUserData();
  }
}
