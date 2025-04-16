import 'package:injectable/injectable.dart';
import 'package:short_path/src/data/dto_models/user_info/Additional_info_dto.dart';
import 'package:short_path/src/data/dto_models/user_info/EducationDto.dart';
import 'package:short_path/src/data/dto_models/user_info/ProjectDto.dart';
import 'package:short_path/src/data/dto_models/user_info/certification_do.dart';
import 'package:short_path/src/data/dto_models/user_info/language_dto.dart';
import 'package:short_path/src/data/dto_models/user_info/profile_dto.dart';

import '../../../../api/api_services.dart';
import '../../../../dto_models/user_info/skills_dto.dart';
import '../../../../dto_models/user_info/work_experience_dto.dart';
import '../contracts/profile_online_datasource.dart';

@Injectable(as: ProfileOnlineDataSource)
class ProfileOnlineDatasourceImpl implements ProfileOnlineDataSource {
  ApiServices _apiServices;

  ProfileOnlineDatasourceImpl(this._apiServices);

  @override
  Future<List<CertificationsDto>> getCertification() async {
    var certification = await _apiServices.getCertification();
    List<CertificationsDto> certificationDto = [];
    for (var cert in certification) {
      var singleCertificate = cert.toDto();
      certificationDto.add(singleCertificate);
    }
    return certificationDto;
  }

  @override
  Future<AdditionalInformationDto> getAdditionalInfo() async {
    var additionalInfo = await _apiServices.getAdditionalInfo();
    return additionalInfo.toDto();
  }

  @override
  Future<List<EducationsDto>> getEducation() async {
    var education = await _apiServices.getEducation();
    List<EducationsDto> educationDto = [];
    for (var edu in education) {
      var singleEducation = edu.toDto();
      educationDto.add(singleEducation);
    }
    return educationDto;
  }

  @override
  Future<List<LanguageDto>> getLanguage() async {
    var language = await _apiServices.getLanguage();
    List<LanguageDto> languageDto = [];
    for (var lang in language) {
      var singleLanguage = lang.toDto();
      languageDto.add(singleLanguage);
    }
    return languageDto;
  }

  @override
  Future<ProfileDto> getProfile() async {
    var profile = await _apiServices.getProfile();
    return profile.toDto();
  }

  @override
  Future<List<ProjectsMainDto>> getProjects() async {
    var projects = await _apiServices.getProject();
    List<ProjectsMainDto> projectDto = [];
    for (var proj in projects) {
      var singleProject = proj.toDto();
      projectDto.add(singleProject);
    }

    return projectDto;
  }

  @override
  Future<SkillsDto> getSkills() async {
    var skills = await _apiServices.getSkill();
    return skills.toDto();
  }

  @override
  Future<List<WorkExperienceDto>> getWorkExperience() async {
    var workExperience = await _apiServices.getWorkExperience();
    List<WorkExperienceDto> workExperienceDto = [];
    for (var work in workExperience) {
      var singleWork = work.toDto();
      workExperienceDto.add(singleWork);
    }
    return workExperienceDto;
  }
}
