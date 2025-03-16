import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../config/helpers/shared_pref/shared_pre_keys.dart';
import '../../../../config/helpers/shared_pref/shared_pref_helper.dart';

part 'localization_state.dart';

@injectable
class LocalizationViewmodel extends Cubit<LocalizationState> {
  LocalizationViewmodel() : super(LocalizationInitial());
  String cachedLanguageCode = "en";
  Future<void> getSavedLanguage() async {
    String? index =
        await SharedPrefHelper.getString(SharedPrefKeys.languageCode);
    if (index != null && index.isNotEmpty) {
      cachedLanguageCode = index;
    }
    emit(ChangLocalizationState());
  }

  Future<void> cachingLanguageCode({required String languageCode}) async {
    if (cachedLanguageCode == languageCode) {
      return;
    }
    await SharedPrefHelper.setDate(SharedPrefKeys.languageCode, languageCode);
    getSavedLanguage();
  }

  bool isEnglishLanguage() {
    return cachedLanguageCode == "en";
  }
}
