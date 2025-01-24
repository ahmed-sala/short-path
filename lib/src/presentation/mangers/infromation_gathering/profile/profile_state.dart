sealed class ProfileState {
  const ProfileState();
}

class ProfileInitialState extends ProfileState {
  const ProfileInitialState();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileUpdated extends ProfileState {}

class NewLanguageAdded extends ProfileState {
  final Map<String, String> language;

  const NewLanguageAdded(this.language);
}

class LanguageRemoved extends ProfileState {
  final Map<String, String> language;

  const LanguageRemoved(this.language);
}

class LanguageSelected extends ProfileState {
  const LanguageSelected();
}

class SelectLanguage extends ProfileState {
  const SelectLanguage();
}

class SelectLanguageLevel extends ProfileState {
  const SelectLanguageLevel();
}

class SelectJobTitle extends ProfileState {
  const SelectJobTitle();
}

class LanguageChanged extends ProfileState {
  const LanguageChanged();
}

class JobTitleChanged extends ProfileState {
  const JobTitleChanged();
}
