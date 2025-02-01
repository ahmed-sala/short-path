part of 'language_viewmodel.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

final class LanguageLoading extends LanguageState {}

final class LanguageLoaded extends LanguageState {
  final List<String> languages;

  LanguageLoaded({required this.languages});
}

final class LanguageError extends LanguageState {
  final String message;

  LanguageError({required this.message});
}

final class LanguageAdded extends LanguageState {
  final LanguageEntity language;

  LanguageAdded({required this.language});
}

final class LanguageRemoved extends LanguageState {
  final LanguageEntity language;

  LanguageRemoved({required this.language});
}

final class LanguageSelected extends LanguageState {}

final class LanguageChanged extends LanguageState {}

final class LanguageLevelSelected extends LanguageState {}

final class LanguageLevelChanged extends LanguageState {}




