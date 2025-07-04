import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_execute.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/data_source/offline_data_source/auth/contracts/auth_offline_datasource.dart';
import 'package:short_path/src/data/data_source/online_data_source/user_info/contracts/user_info_online_datasource.dart';
import 'package:short_path/src/data/dto_models/user_info/language_dto.dart';
import 'package:short_path/src/data/dto_models/user_info/work_experience_dto.dart';
import 'package:short_path/src/domain/entities/user_info/Certification_Entity.dart';
import 'package:short_path/src/domain/entities/user_info/Project_Entity.dart';
import 'package:short_path/src/domain/entities/user_info/additional_info_entity.dart';
import 'package:short_path/src/domain/entities/user_info/education_entity.dart';
import 'package:short_path/src/domain/entities/user_info/language_entity.dart';
import 'package:short_path/src/domain/entities/user_info/profile_entity.dart';
import 'package:short_path/src/domain/entities/user_info/skill_entity.dart';
import 'package:short_path/src/domain/entities/user_info/work_experience_entity.dart';
import 'package:short_path/src/domain/repositories/contract/user_info_repository.dart';

@Injectable(as: UserInfoRepository)
class UserInfoRepositoryImpl implements UserInfoRepository {
  final UserInfoOnlineDataSource _userInfoOnlineDataSource;
  final AuthOfflineDataSource _authOfflineDataSource;
  UserInfoRepositoryImpl(
    this._userInfoOnlineDataSource,
    this._authOfflineDataSource,
  );
  @override
  Future<ApiResult<void>> saveProfile(ProfileEntity profileDto) async {
    return executeApi<void>(apiCall: () async {
      await _userInfoOnlineDataSource.addProfile(
        profileDto.toProfileDto(),
      );
    });
  }

  @override
  Future<ApiResult<void>> saveSkills(SkillEntity skillEntity) async {
    return await executeApi<void>(apiCall: () async {
      await _userInfoOnlineDataSource.addSkills(
        skillEntity.toSkillsDto(),
      );
    });
  }

  @override
  Future<ApiResult<void>> saveLanguages(List<LanguageEntity> languages) async {
    return await executeApi<void>(apiCall: () async {
      LanguagesDto languagesDto = LanguagesDto(
          languages: languages.map((e) => e.toLanguageDto()).toList());

      print("The languages is ${languagesDto.languages}");
      await _userInfoOnlineDataSource.addLanguage(
        languagesDto,
      );
    });
  }

  @override
  Future<ApiResult<void>> saveEducation(EducationEntity educationEntity) async {
    return await executeApi<void>(apiCall: () async {
      await _userInfoOnlineDataSource.addEducation(
        educationEntity.toDto(),
      );
    });
  }

  @override
  Future<ApiResult<void>> saveCertification(
      CertificationsEntity certificationEntity) async {
    return await executeApi<void>(apiCall: () async {
      await _userInfoOnlineDataSource.addCertification(
        certificationEntity.toDto(),
      );
    });
  }

  @override
  Future<ApiResult<void>> saveProjects(ProjectsEntity projects) async {
    return await executeApi<void>(apiCall: () async {
      await _userInfoOnlineDataSource.addProjects(projects.toDto());
    });
  }

  @override
  Future<ApiResult<void>> saveWorkExperiences(
      List<WorkExperienceEntity> workExperiences) async {
    return executeApi<void>(apiCall: () async {
      WorkExperiencesDto workExperienceDto = WorkExperiencesDto(
          workExperiences:
              workExperiences.map((e) => e.toWorkExperienceDto()).toList());

      await _userInfoOnlineDataSource.addWorkExperience(
        workExperienceDto,
      );
    });
  }

  @override
  Future<ApiResult<void>> saveAdditionalInfo(
      AdditionalInfoEntity additionalInfo) async {
    return await executeApi<void>(apiCall: () async {
      await _userInfoOnlineDataSource.addAdditionalInfo(
        additionalInfo.toDto(),
      );
    });
  }
}
