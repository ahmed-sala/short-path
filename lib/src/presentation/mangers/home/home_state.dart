part of 'home_viewmodel.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class UserDataLoading extends HomeState {}

final class UserDataLoaded extends HomeState {
  final AppUser? appUser;
  UserDataLoaded(this.appUser);
}

final class UserDataError extends HomeState {
  final String message;
  UserDataError(this.message);
}

final class SessionExpired extends HomeState {}
