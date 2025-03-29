part of 'personal_profile_viewmodel.dart';

@immutable
sealed class PersonalProfileState {}

final class PersonalProfileInitial extends PersonalProfileState {}

final class PersonalProfileLoading extends PersonalProfileState {}

final class PersonalProfileLoaded extends PersonalProfileState {}

final class PersonalProfileError extends PersonalProfileState {
  final String message;

  PersonalProfileError(this.message);
}

final class SessionExpired extends PersonalProfileState {
  final String message;

  SessionExpired(this.message);
}
