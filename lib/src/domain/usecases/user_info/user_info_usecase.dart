import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/user_info/language_entity.dart';
import 'package:short_path/src/domain/repositories/contract/user_info_repository.dart';

import '../../entities/user_info/profile_entity.dart';
import '../../entities/user_info/skill_entity.dart';

@injectable
class UserInfoUsecase {
  UserInfoRepository _userInfoRepository;
  UserInfoUsecase(this._userInfoRepository);
  Future<ApiResult<void>> invokeProfile(
      ProfileEntity profile) async {
    return await _userInfoRepository.saveProfile(profile);
  }

  Future<ApiResult<void>> invokeSkills(SkillEntity skillEntity) async {
    return await _userInfoRepository.saveSkills(skillEntity);
  }

  Future<ApiResult<void>> invokeLanguages(List<LanguageEntity> languages) async {
    return await _userInfoRepository.saveLanguages(languages);
  }

  Future<ApiResult<void>> invokeWorkExperience(List<WorkExperienceEntity> workExperienceEntity) async {
    return await _userInfoRepository.saveWorkExperiences(workExperienceEntity);
  }
}
