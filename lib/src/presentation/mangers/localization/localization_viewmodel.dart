import 'dart:ui' as ui; // for window.locale
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../config/helpers/shared_pref/shared_pre_keys.dart';
import '../../../../config/helpers/shared_pref/shared_pref_helper.dart';
import '../../../../config/localization/app_localizations.dart';
import '../../../../core/common/common_imports.dart';

part 'localization_state.dart';

@injectable
class LocalizationViewmodel extends Cubit<LocalizationState> {
  LocalizationViewmodel() : super(LocalizationInitial()) {
    _bootstrap();
  }

  /// in-memory cache
  String cachedLanguageCode = 'en';

  /// called once, right after construction
  Future<void> _bootstrap() async {
    await getSavedLanguage();
  }

  /// 1️⃣ Load from prefs or default to device locale + persist
  Future<void> getSavedLanguage() async {
    final deviceLang = ui.PlatformDispatcher.instance.locale.languageCode;
    debugPrint('[Locale] deviceLang=$deviceLang');

    debugPrint('[Locale] loading saved language…');
    final saved = await SharedPrefHelper.getString(SharedPrefKeys.languageCode);

    if (saved != null && saved.isNotEmpty) {
      debugPrint('[Locale] found in prefs: $saved');
      cachedLanguageCode = saved;
    } else {
      // first run → grab device locale
      final deviceLang = ui.PlatformDispatcher.instance.locale.languageCode;
      debugPrint('[Locale] no saved code, deviceLang=$deviceLang');

      if (AppLocalizations.supportedLocales
          .map((l) => l.languageCode)
          .contains(deviceLang)) {
        cachedLanguageCode = deviceLang;
      } else {
        cachedLanguageCode = 'en';
      }

      debugPrint('[Locale] defaulting to: $cachedLanguageCode → persisting');
      await SharedPrefHelper.setDate(
        SharedPrefKeys.languageCode,
        cachedLanguageCode,
      );
    }

    emit(ChangLocalizationState());
  }

  /// 2️⃣ On user change: update in-memory, persist, emit—no reload
  Future<void> cachingLanguageCode({
    required String languageCode,
  }) async {
    if (languageCode == cachedLanguageCode) {
      debugPrint('[Locale] change requested but already $languageCode');
      return;
    }

    debugPrint('[Locale] switching from $cachedLanguageCode → $languageCode');
    cachedLanguageCode = languageCode;
    await SharedPrefHelper.setDate(
      SharedPrefKeys.languageCode,
      languageCode,
    );
    emit(ChangLocalizationState());
  }

  bool isEnglishLanguage() => cachedLanguageCode == 'en';
}
