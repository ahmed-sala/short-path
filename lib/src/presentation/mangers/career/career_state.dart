part of 'career_viewmodel.dart';

@immutable
sealed class CareerState {}

final class CareerInitial extends CareerState {}

final class DownloadCvLoading extends CareerState {}

final class DownloadCvError extends CareerState {
  final String message;
  DownloadCvError(this.message);
}

final class DownloadCvSuccess extends CareerState {}
