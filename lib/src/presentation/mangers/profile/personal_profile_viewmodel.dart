import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/api/core/error/error_handler.dart';
import 'package:short_path/src/domain/usecases/profile/profile_usecase.dart';

import '../../../../core/common/common_imports.dart';
import '../../../domain/entities/auth/app_user.dart';
import '../../../domain/entities/user_info/Certification_Entity.dart';
import '../../../domain/entities/user_info/Project_Entity.dart';
import '../../../domain/entities/user_info/additional_info_entity.dart';
import '../../../domain/entities/user_info/education_entity.dart';
import '../../../domain/entities/user_info/language_entity.dart';
import '../../../domain/entities/user_info/profile_entity.dart';
import '../../../domain/entities/user_info/skill_entity.dart';
import '../../../domain/entities/user_info/work_experience_entity.dart';

part 'personal_profile_state.dart';

@injectable
class PersonalProfileCubit extends Cubit<PersonalProfileState> {
  ProfileUsecase _profileUsecase;
  PersonalProfileCubit(this._profileUsecase) : super(PersonalProfileInitial());

  ProfileEntity? profileEntity;
  SkillEntity? skillEntity;
  List<LanguageEntity>? languageEntity;
  List<WorkExperienceEntity>? workExperienceEntity;
  EducationEntity? educationEntity;
  CertificationsEntity? certificationsEntity;
  ProjectsEntity? projectsEntity;
  AdditionalInfoEntity? additionalInfoEntity;
  AppUser? appUser;

  void getProfile() async {
    emit(ProfileLoadingState());
    final result = await _profileUsecase.getProfile();
    switch (result) {
      case Success<ProfileEntity?>():
        profileEntity = result.data;
        emit(ProfileLoadedState());
        break;
      case Failures<ProfileEntity?>():
        var errorMessages = ErrorHandler.fromException(result.exception);
        if (errorMessages.code == 401 || errorMessages.code == 403) {
          emit(SessionExpired(errorMessages.errorMessage));
        }
        emit(PersonalProfileError(errorMessages.errorMessage));
    }
  }

  void getSkills() async {
    emit(SkillsLoadingState());
    final result = await _profileUsecase.getSkills();
    switch (result) {
      case Success<SkillEntity?>():
        skillEntity = result.data;
        emit(SkillsLoadedState());
        break;
      case Failures<SkillEntity?>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;
        emit(PersonalProfileError(errorMessages));
    }
  }

  void getLanguages() async {
    emit(LanguagesLoadingState());
    final result = await _profileUsecase.getLanguages();
    switch (result) {
      case Success<List<LanguageEntity>?>():
        languageEntity = result.data;
        emit(LanguagesLoadedState());
        break;
      case Failures<List<LanguageEntity>?>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;
        emit(PersonalProfileError(errorMessages));
    }
  }

  void getWorkExperiences() async {
    emit(WorkExperienceLoadingState());
    final result = await _profileUsecase.getWorkExperiences();
    switch (result) {
      case Success<List<WorkExperienceEntity>?>():
        workExperienceEntity = result.data;
        emit(WorkExperienceLoadedState());
        break;
      case Failures<List<WorkExperienceEntity>?>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;
        emit(PersonalProfileError(errorMessages));
    }
  }

  void getEducation() async {
    emit(EducationLoadingState());
    final result = await _profileUsecase.getEducation();
    switch (result) {
      case Success<EducationEntity?>():
        educationEntity = result.data;
        emit(EducationLoadedState());
        break;
      case Failures<EducationEntity?>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;
        emit(PersonalProfileError(errorMessages));
    }
  }

  void getCertification() async {
    emit(CertificationsLoadingState());
    final result = await _profileUsecase.getCertification();
    switch (result) {
      case Success<CertificationsEntity?>():
        certificationsEntity = result.data;
        emit(CertificationsLoadedState());
        break;
      case Failures<CertificationsEntity?>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;
        emit(PersonalProfileError(errorMessages));
    }
  }

  void getProjects() async {
    emit(ProjectsLoadingState());
    final result = await _profileUsecase.getProjects();
    switch (result) {
      case Success<ProjectsEntity?>():
        projectsEntity = result.data;
        emit(ProjectsLoadedState());
        break;
      case Failures<ProjectsEntity?>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;
        emit(PersonalProfileError(errorMessages));
    }
  }

  void getAdditionalInfo() async {
    print('getAdditionalInfo called');

    emit(AdditionalInfoLoadingState());
    final result = await _profileUsecase.getAdditionalInfo();
    switch (result) {
      case Success<AdditionalInfoEntity?>():
        additionalInfoEntity = result.data;
        print('the additional info is ${additionalInfoEntity}');

        emit(AdditionalInfoLoadedState());
        break;
      case Failures<AdditionalInfoEntity?>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;
        print('Error fetching additional info: $errorMessages');

        emit(PersonalProfileError(errorMessages));
    }
  }

  void getUser() async {
    emit(PersonalProfileLoading());
    final result = await _profileUsecase.getUser();
    switch (result) {
      case Success<AppUser?>():
        appUser = result.data;
        emit(PersonalProfileLoaded());
        break;
      case Failures<AppUser?>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;
        emit(PersonalProfileError(errorMessages));
    }
  }
}
