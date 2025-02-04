import 'package:injectable/injectable.dart';
import 'package:short_path/src/data/api/core/api_request_model/user_info/skill_request.dart';
import 'package:short_path/src/data/dto_models/user_info/language_dto.dart';
import 'package:short_path/src/data/dto_models/user_info/profile_dto.dart';

import '../../../../api/api_services.dart';
import '../../../../dto_models/user_info/skills_dto.dart';
import '../../../../dto_models/user_info/work_experience_dto.dart';
import '../contracts/user_info_online_datasource.dart';

@Injectable(as: UserInfoOnlineDataSource)
class UserInfoOnlineDatasourceImpl implements UserInfoOnlineDataSource {
  ApiServices _apiServices;

  UserInfoOnlineDatasourceImpl(this._apiServices);

  @override
  Future<void> addProfile(ProfileDto profileRequest, String token) async {
    await _apiServices.addProfile(
      profileRequest.toProfileRequest(),
      "Bearer $token",
    );
  }

  @override
  Future<void> addSkills(SkillsDto skillsRequest, String token) async {
    var skills = skillsRequest.toSkillsRequest();
    print(skills.skills?.industrySpecificSkills);
    print(skills.skills!.technicalSkills?[0].skill);
    print(skills.skills!.technicalSkills?[0].proficiency);
    print("============");
    print(skills.skills?.softSkills);
    print("============");
    print(skills.toJson());
    SkillRequest skillRequest = SkillRequest(
      skills: Skills(
        technicalSkills: skills.skills!.technicalSkills,
        softSkills: skills.skills!.softSkills,
        industrySpecificSkills: skills.skills!.industrySpecificSkills,
      ),
    );
    await _apiServices.addSkill(skillRequest, "Bearer $token");
  }

  @override
  Future<void> addLanguage(LanguagesDto languageRequest, String token) {
    return _apiServices.addLanguage(
        languageRequest.toLanguagesRequest(), token);
  }

  @override
  Future<void> addWorkExperience(WorkExperiencesDto workExperiencesRequest, String token) async {
    var workExperience = workExperiencesRequest.toWorkExperienceRequest();
    await _apiServices.addWorkExperience(workExperience, "Bearer $token");
  }
}
