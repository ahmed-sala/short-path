import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/src/domain/entities/user_info/language_entity.dart';
import 'package:short_path/src/domain/entities/user_info/profile_entity.dart';
import 'package:short_path/src/domain/usecases/user_info/user_info_usecase.dart';
import 'package:short_path/src/presentation/mangers/user_info/profile/profile_state.dart';

import '../../../../../core/common/api/api_result.dart';
import '../../../../data/api/core/error/error_handler.dart';
import '../../../../data/static_data/demo_data_list.dart';

@injectable
@singleton
class ProfileViewmodel extends Cubit<ProfileState> {
  UserInfoUsecase userInfoUsecase;
  ProfileViewmodel(this.userInfoUsecase) : super(const ProfileInitialState()) {
    // Attach listeners to the controllers
    jobTitleController.addListener(onJobTitleChanged);
    languageController.addListener(onLanguageChanged);
  }

  bool checkValidLink(String link) {
    return Uri.parse(link).isAbsolute;
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController linkedInController = TextEditingController();
  TextEditingController profilePictureController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController portfolioController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  List<LanguageEntity> languages = [];
  String? selectedLanguageLevel;
  List<String> filteredJobSuggestions = [];
  List<String> filteredLanguageSuggestions = [];
  bool validate = false;

  List<String> portfolioLinks = [];

  List<String> languageLevels = [
    'Beginner',
    'Intermediate',
    'Advanced',
    'Fluent',
    'Native'
  ];

  void onJobTitleChanged() {
    filteredJobSuggestions = jobTitleController.text.isEmpty
        ? jobSuggestions
        : jobSuggestions
            .where((job) => job
                .toLowerCase()
                .startsWith(jobTitleController.text.toLowerCase()))
            .toList();
    emit(const JobTitleChanged());
  }

  void onLanguageChanged() {
    filteredLanguageSuggestions = languageController.text.isEmpty
        ? languageSuggestions
        : languageSuggestions
            .where((language) => language
                .toLowerCase()
                .startsWith(languageController.text.toLowerCase()))
            .toList();
    emit(const LanguageChanged());
  }

  void next() async {
    if (formKey.currentState!.validate()) {
      emit(const ProfileLoading());
      ProfileEntity profileEntity = ProfileEntity(
        yearOfExperience: 0,
        projectsCompleted: 0,
        bio: bioController.text,
        jobTitle: jobTitleController.text,
        linkedIn: linkedInController.text,
        portfolioLinks: portfolioLinks,
        profilePicture: profilePictureController.text,
      );

      print('Profile: ${profileEntity.portfolioLinks}');

      var response = await userInfoUsecase.invokeProfile(profileEntity);
      print('Response: $response');
      switch (response) {
        case Success<void>():
          emit(const ProfileUpdateSuccess());
          break;
        case Failures<void>():
          final error = ErrorHandler.fromException(response.exception);
          print('Error: ${error.errorMessage}, with code ${error.code}');
          emit(ProfileUpdateError(error.errorMessage));
          break;
      }
    }
  }

  void selectJobTitle(int index) {
    jobTitleController.text = filteredJobSuggestions[index];
    filteredJobSuggestions = [];
    emit(const SelectJobTitle());
  }

  void selectLanguageLevel(String? value) {
    selectedLanguageLevel = value;
    emit(const SelectLanguageLevel());
  }

  void selectLanguage(int index) {
    languageController.text = filteredLanguageSuggestions[index];
    filteredLanguageSuggestions = [];
    emit(const SelectLanguage());
  }

  void addLanguage(String language, String level) {
    LanguageEntity languageEntity =
        LanguageEntity(language: language, level: level);
    if (languages.contains(languageEntity)) {
      return;
    } else if (languages.length == 5) {
      return;
    } else if (language.isEmpty) {
      return;
    }
    languages.add(languageEntity);
    emit(NewLanguageAdded(languageEntity));
  }

  void removeLanguage(LanguageEntity language) {
    languages.remove(language);
    emit(LanguageRemoved(language));
  }

  void addPortfolioLink(String link) {
    if (portfolioLinks.contains(link)) {
      return;
    } else if (portfolioLinks.length == 5) {
      return;
    } else if (link.isEmpty) {
      return;
    }
    portfolioLinks.add(link);
    emit(PortfolioLinkAdded(link));
  }

  void removePortfolioLink(String link) {
    portfolioLinks.remove(link);
    emit(PortfolioLinkRemoved(link));
  }

  validateColorButton() {
    if (jobTitleController.text.isEmpty ||
        profilePictureController.text.isEmpty ||
        linkedInController.text.isEmpty ||
        bioController.text.isEmpty) {
      validate = false;
    } else if (!formKey.currentState!.validate()) {
      validate = false;
    } else {
      validate = true;
    }
    emit(const ValidateColorButtonState());
  }

  @override
  Future<void> close() {
    jobTitleController.dispose();
    linkedInController.dispose();
    profilePictureController.dispose();
    languageController.dispose();
    portfolioController.dispose();
    bioController.dispose();
    return super.close();
  }
}
