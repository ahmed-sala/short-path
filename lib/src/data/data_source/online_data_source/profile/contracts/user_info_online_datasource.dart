import 'package:short_path/src/data/dto_models/user_info/Additional_info_dto.dart';
import 'package:short_path/src/data/dto_models/user_info/EducationDto.dart';
import 'package:short_path/src/data/dto_models/user_info/ProjectDto.dart';
import 'package:short_path/src/data/dto_models/user_info/certification_do.dart';
import 'package:short_path/src/data/dto_models/user_info/language_dto.dart';
import 'package:short_path/src/data/dto_models/user_info/profile_dto.dart';
import 'package:short_path/src/data/dto_models/user_info/skills_dto.dart';
import 'package:short_path/src/data/dto_models/user_info/work_experience_dto.dart';

abstract interface class UserInfoOnlineDataSource {
  Future<void> addProfile(
    ProfileDto profileRequest,
  );
  Future<void> addSkills(SkillsDto skillsRequest);

  Future<void> addLanguage(LanguagesDto languagesRequest);

  Future<void> addWorkExperience(
    WorkExperiencesDto workExperiencesRequest,
  );
  Future<void> addEducation(
    EducationDto educationRequest,
  );
  Future<void> addCertification(
    CertificationDto certificationRequest,
  );
  Future<void> addProjects(
    ProjectDto projectRequest,
  );

  Future<void> addAdditionalInfo(
    AdditionalInfoDto additionalInfoDto,
  );
}
