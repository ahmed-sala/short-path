import 'package:short_path/src/data/dto_models/user_info/Additional_info_dto.dart';
import 'package:short_path/src/data/dto_models/user_info/EducationDto.dart';
import 'package:short_path/src/data/dto_models/user_info/ProjectDto.dart';
import 'package:short_path/src/data/dto_models/user_info/certification_do.dart';
import 'package:short_path/src/data/dto_models/user_info/language_dto.dart';
import 'package:short_path/src/data/dto_models/user_info/profile_dto.dart';
import 'package:short_path/src/data/dto_models/user_info/skills_dto.dart';
import 'package:short_path/src/data/dto_models/user_info/work_experience_dto.dart';

abstract interface class ProfileOnlineDataSource {
  Future<ProfileDto> getProfile();
  Future<SkillsDto> getSkills();

  Future<List<LanguageDto>> getLanguage();

  Future<List<WorkExperienceDto>> getWorkExperience();
  Future<List<EducationsDto>> getEducation();
  Future<List<CertificationsDto>> getCertification();
  Future<List<ProjectsMainDto>> getProjects();

  Future<AdditionalInformationDto> getAdditionalInfo();
}
