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

final class InterviewPreparationLoading extends CvState {}

final class InterviewPreparationLoaded extends CvState {
  final List<String> questions;
  final List<String> answers;

  InterviewPreparationLoaded({
    required this.questions,
    required this.answers,
  });
}

final class InterviewPreparationError extends CvState {
  final String errorMessage;

  InterviewPreparationError(this.errorMessage);
}
