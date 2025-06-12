sealed class JobDetailState {}

final class JobDetailInitial extends JobDetailState {}

final class GenerateCoverSheetLoading extends JobDetailState {}

final class GenerateCoverSheetError extends JobDetailState {
  final String message;

  GenerateCoverSheetError(this.message);
}

final class GenerateCoverSheetSuccess extends JobDetailState {}

final class InterviewPreparationLoading extends JobDetailState {}

final class InterviewPreparationLoaded extends JobDetailState {
  final List<String> questions;
  final List<String> answers;

  InterviewPreparationLoaded({
    required this.questions,
    required this.answers,
  });
}

final class InterviewPreparationError extends JobDetailState {
  final String errorMessage;

  InterviewPreparationError(this.errorMessage);
}
