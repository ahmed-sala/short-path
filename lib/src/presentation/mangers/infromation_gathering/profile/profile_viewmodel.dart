import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/src/presentation/mangers/infromation_gathering/profile/profile_state.dart';

import '../../../../data/static_data/demo_data_list.dart';

@injectable
class ProfileViewmodel extends Cubit<ProfileState> {
  ProfileViewmodel() : super(ProfileInitialState()) {
    // Attach listeners to the controllers
    jobTitleController.addListener(onJobTitleChanged);
    languageController.addListener(onLanguageChanged);
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController languageController = TextEditingController();

  List<Map<String, String>> languages = [];
  String? selectedLanguageLevel;
  List<String> filteredJobSuggestions = [];
  List<String> filteredLanguageSuggestions = [];
  bool isFormValid = false;

  List<String> languageLevels = ['Beginner', 'Moderate', 'Advanced'];
  void validateForm() {
    isFormValid = formKey.currentState?.validate() ?? false;
    emit(ProfileUpdated());
  }

  String? validateJobTitle(String? value) =>
      value?.isEmpty == true ? 'Please enter your job title' : null;

  String? validateGitHubProfile(String? value) =>
      value?.isEmpty == true ? 'Please enter your GitHub profile URL' : null;

  String? validateLinkedInProfile(String? value) =>
      value?.isEmpty == true ? 'Please enter your LinkedIn profile URL' : null;

  String? validateProfilePicture(String? value) =>
      value?.isEmpty == true ? 'Please enter your profile picture URL' : null;

  void onJobTitleChanged() {
    filteredJobSuggestions = jobTitleController.text.isEmpty
        ? jobSuggestions
        : jobSuggestions
            .where((job) => job
                .toLowerCase()
                .startsWith(jobTitleController.text.toLowerCase()))
            .toList();
    emit(JobTitleChanged());
  }

  void onLanguageChanged() {
    filteredLanguageSuggestions = languageController.text.isEmpty
        ? languageSuggestions
        : languageSuggestions
            .where((language) => language
                .toLowerCase()
                .startsWith(languageController.text.toLowerCase()))
            .toList();
    emit(LanguageChanged());
  }

  void selectJobTitle(int index) {
    jobTitleController.text = filteredJobSuggestions[index];
    filteredJobSuggestions = [];
    emit(SelectJobTitle());
  }

  void selectLanguageLevel(String? value) {
    selectedLanguageLevel = value;
    emit(SelectLanguageLevel());
  }

  void selectLanguage(int index) {
    languageController.text = filteredLanguageSuggestions[index];
    filteredLanguageSuggestions = [];
    emit(SelectLanguage());
  }

  void addLanguage(Map<String, String> language) {
    languages.add(language);
    emit(NewLanguageAdded(language));
  }

  void removeLanguage(Map<String, String> language) {
    languages.remove(language);
    emit(LanguageRemoved(language));
  }

  void validateAndProceed() {
    if (formKey.currentState?.validate() ?? false) {
      emit(ProfileUpdated());
    } else {
      // Show error message
    }
  }
}
