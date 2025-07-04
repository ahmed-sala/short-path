import 'package:injectable/injectable.dart';
import 'package:short_path/src/data/api/core/api_request_model/user_info/skill_request.dart';
import 'package:short_path/src/data/dto_models/user_info/Additional_info_dto.dart';
import 'package:short_path/src/data/dto_models/user_info/EducationDto.dart';
import 'package:short_path/src/data/dto_models/user_info/ProjectDto.dart';
import 'package:short_path/src/data/dto_models/user_info/certification_do.dart';
import 'package:short_path/src/data/dto_models/user_info/language_dto.dart';
import 'package:short_path/src/data/dto_models/user_info/profile_dto.dart';

import '../../../../api/api_services.dart';
import '../../../../dto_models/user_info/skills_dto.dart';
import '../../../../dto_models/user_info/work_experience_dto.dart';
import '../contracts/user_info_online_datasource.dart';

@Injectable(as: UserInfoOnlineDataSource)
class UserInfoOnlineDatasourceImpl implements UserInfoOnlineDataSource {
  final ApiServices _apiServices;

  UserInfoOnlineDatasourceImpl(this._apiServices);

  @override
  Future<void> addProfile(ProfileDto profileRequest) async {
    await _apiServices.addProfile(
      profileRequest.toProfileRequest(),
    );
  }

  @override
  Future<void> addSkills(
    SkillsDto skillsRequest,
  ) async {
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
    return await _apiServices.addSkill(
      skillRequest,
    );
  }

  @override
  Future<void> addLanguage(LanguagesDto languageRequest) async {
    return await _apiServices.addLanguage(
      languageRequest.toLanguagesRequest(),
    );
  }

  @override
  Future<void> addEducation(
    EducationDto educationRequest,
  ) async {
    print(
        'Education Request: ${educationRequest.educations?[0].degreeCertification}');
    print(
        'Education Request: ${educationRequest.educations?[0].institutionName}');
    print(
        'Education Request: ${educationRequest.educations?[0].projects?[0].projectName}');
    return await _apiServices.addEducation(
      educationRequest.toRequest(),
    );
  }

  @override
  Future<void> addCertification(
    CertificationDto certificationRequest,
  ) async {
    return await _apiServices.addCertification(
      certificationRequest.toRequest(),
    );
  }

  @override
  Future<void> addProjects(
    ProjectDto projectRequest,
  ) async {
    return await _apiServices.addProject(
      projectRequest.toRequest(),
    );
  }

  @override
  Future<void> addWorkExperience(
    WorkExperiencesDto workExperiencesRequest,
  ) async {
    var workExperience = workExperiencesRequest.toWorkExperienceRequest();
    await _apiServices.addWorkExperience(
      workExperience,
    );
  }

  @override
  Future<void> addAdditionalInfo(
    AdditionalInfoDto additionalInfoDto,
  ) async {
    return await _apiServices.addAdditionalInfo(
      additionalInfoDto.toRequest(),
    );
  }
}
