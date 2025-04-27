part of 'cv_cubit.dart';

@immutable
sealed class CvState {}

final class CvInitial extends CvState {}

final class DownloadCvLoading extends CvState {}

final class DownloadCvError extends CvState {
  final String message;
  DownloadCvError(this.message);
}

final class DownloadCvSuccess extends CvState {}
