part of 'personal_profile_viewmodel.dart';

@immutable
abstract class PersonalProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PersonalProfileInitial extends PersonalProfileState {}

class PersonalProfileLoading extends PersonalProfileState {}

class PersonalProfileLoaded extends PersonalProfileState {}

class PersonalProfileError extends PersonalProfileState {
  final String message;

  PersonalProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class SessionExpired extends PersonalProfileState {
  final String message;

  SessionExpired(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileLoadingState extends PersonalProfileState {}

class ProfileLoadedState extends PersonalProfileState {}

class SkillsLoadingState extends PersonalProfileState {}

class SkillsLoadedState extends PersonalProfileState {}

class LanguagesLoadingState extends PersonalProfileState {}

class LanguagesLoadedState extends PersonalProfileState {}

class WorkExperienceLoadingState extends PersonalProfileState {}

class WorkExperienceLoadedState extends PersonalProfileState {}

class EducationLoadingState extends PersonalProfileState {}

class EducationLoadedState extends PersonalProfileState {}

class AdditionalInfoLoadingState extends PersonalProfileState {}

class AdditionalInfoLoadedState extends PersonalProfileState {}

class CertificationsLoadingState extends PersonalProfileState {}

class CertificationsLoadedState extends PersonalProfileState {}

class ProjectsLoadingState extends PersonalProfileState {}

class ProjectsLoadedState extends PersonalProfileState {}

class TabChangedState extends PersonalProfileState {
  final int index;

  TabChangedState(this.index);

  @override
  List<Object?> get props => [index];
}

class LogOutLoadingState extends PersonalProfileState {}
class LogOutLoadedState extends PersonalProfileState {}
