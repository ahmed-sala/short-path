import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/user_info/language_entity.dart';
import 'package:short_path/src/domain/entities/user_info/profile_entity.dart';
import 'package:short_path/src/domain/entities/user_info/skill_entity.dart';

import '../../entities/user_info/work_experience_entity.dart';

abstract interface class UserInfoRepository {
  Future<ApiResult<void>> saveProfile(
      ProfileEntity profileDto);
  Future<ApiResult<void>> saveSkills(SkillEntity skillEntity);

  Future<ApiResult<void>> saveLanguages(List<LanguageEntity> languages);
  Future<ApiResult<void>> saveWorkExperiences(
      List<WorkExperienceEntity> workExperiences);
}
