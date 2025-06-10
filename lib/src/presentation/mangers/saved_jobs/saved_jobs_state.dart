part of 'saved_jobs_cubit.dart';

@immutable
sealed class SavedJobsState {}

final class SavedJobsInitial extends SavedJobsState {}

final class SavedJobsLoading extends SavedJobsState {}

final class SavedJobsLoaded extends SavedJobsState {
  SavedJobsLoaded();
}

final class SavedJobsError extends SavedJobsState {
  final String message;

  SavedJobsError(this.message);
}

final class SaveJobsSuccess extends SavedJobsState {
  SaveJobsSuccess();
}

final class SavedJobsFailure extends SavedJobsState {
  final String errorMessage;

  SavedJobsFailure(this.errorMessage);
}

final class DeleteSavedJobSuccess extends SavedJobsState {
  DeleteSavedJobSuccess();
}

final class DeleteSavedJobFailure extends SavedJobsState {
  final String errorMessage;

  DeleteSavedJobFailure(this.errorMessage);
}
