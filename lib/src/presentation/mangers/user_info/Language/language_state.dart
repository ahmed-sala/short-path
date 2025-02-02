
import '../../../../domain/entities/user_info/language_entity.dart';

sealed class LanguageState {
  const LanguageState();
}
class LanguageInitial extends LanguageState {
  const LanguageInitial();
}

class LanguageChanged extends LanguageState {
  const LanguageChanged();
}

class SelectLanguageLevel extends LanguageState {
  const SelectLanguageLevel();
}

class SelectLanguage extends LanguageState {
  const SelectLanguage();
}

class NewLanguageAdded extends LanguageState {
  final LanguageEntity language;

  const NewLanguageAdded(this.language);
}

class LanguageRemoved extends LanguageState {
  final LanguageEntity language;

  const LanguageRemoved(this.language);
}
