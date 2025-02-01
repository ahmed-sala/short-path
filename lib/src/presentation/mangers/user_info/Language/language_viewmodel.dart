import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:short_path/src/domain/usecases/user_info/user_info_usecase.dart';

import '../../../../../core/common/api/api_result.dart';
import '../../../../data/api/core/error/error_handler.dart';
import '../../../../data/static_data/demo_data_list.dart';
import '../../../../domain/entities/user_info/language_entity.dart';

part 'language_state.dart';

@injectable
@singleton
class LanguageViewModel extends Cubit<LanguageState> {

  UserInfoUsecase userInfoUsecase;

  LanguageViewModel(this.userInfoUsecase) : super(LanguageInitial()){
    languageController.addListener(() {
      onChangedLanguage();
    });
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController languageController = TextEditingController();

  List<LanguageEntity> languages = [];
  List<String> languageLevels = [
    'Beginner',
    'Intermediate',
    'Advanced',
    'Fluent',
    'Native'
  ];

  String? selectedLanguageLevel;
  List<String> filteredLanguageSuggestions = [];

  void addLanguage(String language,String level) {
    print('Languages: $languages');
    LanguageEntity newLanguage = LanguageEntity(language: language, level: level);
    if(languages.contains(newLanguage)) {
      emit(LanguageError(message: 'Language already exists'));
      return;
    }
    else if (language.isEmpty) {
      emit(LanguageError(message: 'Please enter a language'));
      return;
    }
    else if (level.isEmpty) {
      emit(LanguageError(message: 'Please select a level'));
      return;
    }
    languages.add(newLanguage);
    print('Languages: $languages');
    emit(LanguageAdded(language: newLanguage));
  }

  void removeLanguage(LanguageEntity language) {
    languages.remove(language);
    emit(LanguageRemoved(language: language));
  }

  void changeLanguageLevel(String level) {
    selectedLanguageLevel = level;
    emit(LanguageLevelChanged());
  }

  void changeLanguage(String language) {
    emit(LanguageChanged());
  }

  void selectLanguage(int index) {
    languageController.text = filteredLanguageSuggestions[index];
    filteredLanguageSuggestions = [];
    emit(LanguageSelected());
  }

  void selectLanguageLevel(String? value) {
    selectedLanguageLevel = value;
    emit(LanguageLevelSelected());
  }

  void onChangedLanguage () {
    filteredLanguageSuggestions = languageController.text.isEmpty
        ? languageSuggestions
        : languageSuggestions
        .where((language) => language
        .toLowerCase()
        .startsWith(languageController.text.toLowerCase()))
        .toList();
    emit(LanguageChanged());
  }

  void next() async{
    if(formKey.currentState!.validate()){
      emit(LanguageLoading());
      var result = await userInfoUsecase.invokeLanguages(languages);
      switch (result) {
        case Success<void>():
          emit(LanguageLoaded(languages: languages.map((e) => e.language).toList()));
          break;
        case Failures<void>():
          final error = ErrorHandler.fromException(result.exception);
          print('Error: ${error.errorMessage}, with code ${error.code}');
          emit(LanguageError(message: error.errorMessage));
          break;
      }
    }
  }

  @override
  Future<void> close() {
    languageController.dispose();
    return super.close();
  }



}
