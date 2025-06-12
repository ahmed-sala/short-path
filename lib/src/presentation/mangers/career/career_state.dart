part of 'career_viewmodel.dart';

@immutable
sealed class CareerState {}

final class CareerInitial extends CareerState {}

final class GenerateCoverSheetLoading extends CareerState {}

final class GenerateCoverSheetError extends CareerState {
  final String message;

  GenerateCoverSheetError(this.message);
}

final class GenerateCoverSheetSuccess extends CareerState {}

final class InterviewPreparationLoading extends CareerState {}

final class InterviewPreparationLoaded extends CareerState {
  final List<String> questions;
  final List<String> answers;

  InterviewPreparationLoaded({
    required this.questions,
    required this.answers,
  });
}

final class InterviewPreparationError extends CareerState {
  final String errorMessage;

  InterviewPreparationError(this.errorMessage);
}
