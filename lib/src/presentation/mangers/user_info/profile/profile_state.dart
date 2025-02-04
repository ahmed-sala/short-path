import 'package:short_path/src/domain/entities/user_info/language_entity.dart';

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

class ProfileUpdateError extends ProfileState {
  final String message;

  const ProfileUpdateError(this.message);
}

class ProfileUpdateSuccess extends ProfileState {
  const ProfileUpdateSuccess();
}

class NewLanguageAdded extends ProfileState {
  final LanguageEntity language;

  const NewLanguageAdded(this.language);
}

class LanguageRemoved extends ProfileState {
  final LanguageEntity language;

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

class PortfolioLinkAdded extends ProfileState {
  final String link;

  const PortfolioLinkAdded(this.link);
}

class PortfolioLinkRemoved extends ProfileState {
  final String link;

  const PortfolioLinkRemoved(this.link);
}

class ValidateColorButtonState extends ProfileState {
  const ValidateColorButtonState();
}
