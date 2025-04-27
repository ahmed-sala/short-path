import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/user_info/language_entity.dart';
import 'package:short_path/src/domain/usecases/user_info/user_info_usecase.dart';

import '../../../../data/api/core/error/error_handler.dart';
import '../../../../data/static_data/demo_data_list.dart';
import 'language_state.dart';

@injectable
class LanguageViewmodel extends Cubit<LanguageState> {
  final UserInfoUsecase _userInfoUsecase;
  LanguageViewmodel(this._userInfoUsecase) : super(const LanguageInitial()) {
    // Attach listeners to the controllers
    languageController.addListener(onLanguageChanged);
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController languageController = TextEditingController();

  List<LanguageEntity> languages = [];
  String? selectedLanguageLevel;
  List<String> filteredLanguageSuggestions = [];
  bool validate = false;

  List<String> languageLevels = [
    'Beginner',
    'Intermediate',
    'Advanced',
    'Fluent',
    'Native'
  ];

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
        LanguageEntity(language: language, level: level.toUpperCase());
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

  void next() async {
    if (languages.isNotEmpty) {
      emit(const AddLanguageLoading());
      var result = await _userInfoUsecase.invokeLanguages(languages);
      switch (result) {
        case Success<void>():
          emit(const AddLanguageSuccess());
          break;
        case Failures<void>():
          var errorMessage =
              ErrorHandler.fromException(result.exception).errorMessage;
          emit(AddLanguageError(errorMessage));
      }
    } else {
      emit(const AddLanguageError('Please add at least one language'));
    }
  }

  @override
  Future<void> close() {
    languageController.dispose();
    return super.close();
  }
}
