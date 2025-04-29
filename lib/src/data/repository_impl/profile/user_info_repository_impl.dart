import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_execute.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/user_info/Certification_Entity.dart';
import 'package:short_path/src/domain/entities/user_info/Project_Entity.dart';
import 'package:short_path/src/domain/entities/user_info/additional_info_entity.dart';
import 'package:short_path/src/domain/entities/user_info/education_detail_entity.dart';
import 'package:short_path/src/domain/entities/user_info/education_entity.dart';
import 'package:short_path/src/domain/entities/user_info/language_entity.dart';
import 'package:short_path/src/domain/entities/user_info/profile_entity.dart';
import 'package:short_path/src/domain/entities/user_info/skill_entity.dart';
import 'package:short_path/src/domain/entities/user_info/work_experience_entity.dart';
import 'package:short_path/src/domain/repositories/contract/profile_repository.dart';

import '../../data_source/online_data_source/profile/contracts/profile_online_datasource.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileOnlineDataSource _ProfileOnlineDataSource;
  ProfileRepositoryImpl(
    this._ProfileOnlineDataSource,
  );

  @override
  Future<ApiResult<EducationEntity?>> getEducation() async {
    return await executeApi<EducationEntity?>(apiCall: () async {
      var education = await _ProfileOnlineDataSource.getEducation();
      List<EducationDetailEntity> educationEntity = [];
      for (var edu in education) {
        var singleEducation = edu.toEntity();
        educationEntity.add(singleEducation);
      }
      return EducationEntity(educationDetails: educationEntity);
    });
  }

  @override
  Future<ApiResult<List<LanguageEntity>?>> getLanguages() async {
    return await executeApi<List<LanguageEntity>?>(apiCall: () async {
      var language = await _ProfileOnlineDataSource.getLanguage();
      List<LanguageEntity> languageEntity = [];
      for (var lang in language) {
        var singleLanguage = lang.toDomainEntity();
        languageEntity.add(singleLanguage);
      }
      return languageEntity;
    });
  }

  @override
  Future<ApiResult<ProfileEntity?>> getProfile() async {
    return await executeApi<ProfileEntity?>(apiCall: () async {
      var profile = await _ProfileOnlineDataSource.getProfile();
      return profile.toDomainEntity();
    });
  }

  @override
  Future<ApiResult<SkillEntity?>> getSkills() async {
    return await executeApi<SkillEntity?>(apiCall: () async {
      var skills = await _ProfileOnlineDataSource.getSkills();
      return skills.toDomainEntity();
    });
  }

  @override
  Future<ApiResult<List<WorkExperienceEntity>?>> getWorkExperiences() async {
    return await executeApi<List<WorkExperienceEntity>?>(apiCall: () async {
      var workExperience = await _ProfileOnlineDataSource.getWorkExperience();
      List<WorkExperienceEntity> workExperienceEntity = [];
      for (var workExp in workExperience) {
        var singleWorkExperience = workExp.toDomainEntity();
        workExperienceEntity.add(singleWorkExperience);
      }
      return workExperienceEntity;
    });
  }

  @override
  Future<ApiResult<AdditionalInfoEntity?>> getAdditionalInfo() async {
    return await executeApi<AdditionalInfoEntity?>(apiCall: () async {
      var additionalInfo = await _ProfileOnlineDataSource.getAdditionalInfo();
      return additionalInfo.toEntity();
    });
  }

  @override
  Future<ApiResult<CertificationsEntity?>> getCertification() async {
    return await executeApi<CertificationsEntity?>(apiCall: () async {
      var certification = await _ProfileOnlineDataSource.getCertification();
      List<CertificationEntity> certificationEntity = [];
      for (var cert in certification) {
        var singleCertification = cert.toDomainEntity();
        certificationEntity.add(singleCertification);
      }
      return CertificationsEntity(certifications: certificationEntity);
    });
  }

  @override
  Future<ApiResult<ProjectsEntity?>> getProjects() async {
    return await executeApi<ProjectsEntity?>(apiCall: () async {
      var projects = await _ProfileOnlineDataSource.getProjects();
      List<ProjectEntity> projectEntity = [];
      for (var proj in projects) {
        var singleProject = proj.toEntity();
        projectEntity.add(singleProject);
      }
      return ProjectsEntity(projects: projectEntity);
    });
  }
}
