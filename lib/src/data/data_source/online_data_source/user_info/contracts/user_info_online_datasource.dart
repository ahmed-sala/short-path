import 'package:short_path/src/data/dto_models/user_info/ProjectDto.dart';

import '../../../../dto_models/user_info/EducationDto.dart';
import '../../../../dto_models/user_info/certification_do.dart';
import '../../../../dto_models/user_info/language_dto.dart';
import '../../../../dto_models/user_info/profile_dto.dart';
import '../../../../dto_models/user_info/skills_dto.dart';
import '../../../../dto_models/user_info/work_experience_dto.dart';

abstract interface class UserInfoOnlineDataSource {
  Future<void> addProfile(
    ProfileDto profileRequest,
    String token,
  );
  Future<void> addSkills(SkillsDto skillsRequest, String token);

  Future<void> addLanguage(LanguagesDto languagesRequest, String token);

  Future<void> addWorkExperience(
    WorkExperiencesDto workExperiencesRequest,
    String token,
  );
  Future<void> addEducation(EducationDto educationRequest, String token);
  Future<void> addCertification(
      CertificationDto certificationRequest, String token);
  Future<void> addProjects(ProjectDto projectRequest, String token);
}
