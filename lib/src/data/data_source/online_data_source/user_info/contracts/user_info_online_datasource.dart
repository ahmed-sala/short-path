import '../../../../dto_models/user_info/language_dto.dart';
import '../../../../dto_models/user_info/profile_dto.dart';
import '../../../../dto_models/user_info/skills_dto.dart';
import '../../../../dto_models/user_info/work_experience_dto.dart';

abstract interface class UserInfoOnlineDataSource {
  Future<void> addProfile(
    ProfileDto profileRequest,
    LanguagesDto languageRequest,
    String token,
  );
  Future<void> addSkills(SkillsDto skillsRequest, String token);

  Future<void> addWorkExperience(
    WorkExperienceDto workExperienceRequest,
    String token,
  );
}
