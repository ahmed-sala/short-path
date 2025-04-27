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
  final ProfileUsecase _profileUsecase;

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
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    emit(ProfileLoadingState());

    final result = await _profileUsecase.getProfile();
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    switch (result) {
      case Success<ProfileEntity?>():
        profileEntity = result.data;
        if (!isClosed) emit(ProfileLoadedState());
        break;
      case Failures<ProfileEntity?>():
        var errorMessages = ErrorHandler.fromException(result.exception);
        if (errorMessages.code == 401 || errorMessages.code == 403) {
          if (!isClosed) emit(SessionExpired(errorMessages.errorMessage));
        }
        if (!isClosed) emit(PersonalProfileError(errorMessages.errorMessage));
    }
  }

  void getSkills() async {
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    emit(SkillsLoadingState());

    final result = await _profileUsecase.getSkills();
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    switch (result) {
      case Success<SkillEntity?>():
        skillEntity = result.data;
        if (!isClosed) emit(SkillsLoadedState());
        break;
      case Failures<SkillEntity?>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;
        if (!isClosed) emit(PersonalProfileError(errorMessages));
    }
  }

  void getLanguages() async {
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    emit(LanguagesLoadingState());

    final result = await _profileUsecase.getLanguages();
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    switch (result) {
      case Success<List<LanguageEntity>?>():
        languageEntity = result.data;
        if (!isClosed) emit(LanguagesLoadedState());
        break;
      case Failures<List<LanguageEntity>?>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;
        if (!isClosed) emit(PersonalProfileError(errorMessages));
    }
  }

  void getWorkExperiences() async {
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    emit(WorkExperienceLoadingState());

    final result = await _profileUsecase.getWorkExperiences();
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    switch (result) {
      case Success<List<WorkExperienceEntity>?>():
        workExperienceEntity = result.data;
        if (!isClosed) emit(WorkExperienceLoadedState());
        break;
      case Failures<List<WorkExperienceEntity>?>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;
        if (!isClosed) emit(PersonalProfileError(errorMessages));
    }
  }

  void getEducation() async {
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    emit(EducationLoadingState());

    final result = await _profileUsecase.getEducation();
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    switch (result) {
      case Success<EducationEntity?>():
        educationEntity = result.data;
        if (!isClosed) emit(EducationLoadedState());
        break;
      case Failures<EducationEntity?>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;
        if (!isClosed) emit(PersonalProfileError(errorMessages));
    }
  }

  void getCertification() async {
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    emit(CertificationsLoadingState());

    final result = await _profileUsecase.getCertification();
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    switch (result) {
      case Success<CertificationsEntity?>():
        certificationsEntity = result.data;
        if (!isClosed) emit(CertificationsLoadedState());
        break;
      case Failures<CertificationsEntity?>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;
        if (!isClosed) emit(PersonalProfileError(errorMessages));
    }
  }

  void getProjects() async {
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    emit(ProjectsLoadingState());

    final result = await _profileUsecase.getProjects();
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    switch (result) {
      case Success<ProjectsEntity?>():
        projectsEntity = result.data;
        if (!isClosed) emit(ProjectsLoadedState());
        break;
      case Failures<ProjectsEntity?>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;
        if (!isClosed) emit(PersonalProfileError(errorMessages));
    }
  }

  void getAdditionalInfo() async {
    print('getAdditionalInfo called');
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    emit(AdditionalInfoLoadingState());
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    final result = await _profileUsecase.getAdditionalInfo();
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    switch (result) {
      case Success<AdditionalInfoEntity?>():
        additionalInfoEntity = result.data;
        print('the additional info is $additionalInfoEntity');
        if (!isClosed) emit(AdditionalInfoLoadedState());
        break;
      case Failures<AdditionalInfoEntity?>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;
        print('Error fetching additional info: $errorMessages');
        if (!isClosed) emit(PersonalProfileError(errorMessages));
    }
  }

  void getUser() async {
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    emit(PersonalProfileLoading());

    final result = await _profileUsecase.getUser();
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    switch (result) {
      case Success<AppUser?>():
        appUser = result.data;
        if (!isClosed) emit(PersonalProfileLoaded());
        break;
      case Failures<AppUser?>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;
        if (!isClosed) emit(PersonalProfileError(errorMessages));
    }
  }

  void logout() async {
    if (isClosed) return; // Ensure Cubit is not closed before emitting

    emit(LogOutLoadingState());
    await _profileUsecase.logout();
    if (!isClosed) emit(LogOutLoadedState());
  }
}
