part of 'jobs_viewmodel.dart';

@immutable
sealed class JobsState {}

final class AllJobsInitial extends JobsState {}

final class SessionExpired extends JobsState {}

final class AllJobsLoading extends JobsState {}

final class AllJobsLoaded extends JobsState {
  final List<ContentEntity>? jobs;
  AllJobsLoaded(this.jobs);
}

final class AllJobsError extends JobsState {
  final String message;
  AllJobsError(this.message);
}

final class SearchModeState extends JobsState {
  final bool isSearching;
  SearchModeState(this.isSearching);
}

final class SavedJobsInitial extends JobsState {}

final class SavedJobsLoading extends JobsState {}

final class SaveJobsSuccess extends JobsState {
  SaveJobsSuccess();
}

final class SavedJobsFailure extends JobsState {
  final String errorMessage;

  SavedJobsFailure(this.errorMessage);
}

final class DeleteSavedJobSuccess extends JobsState {
  DeleteSavedJobSuccess();
}

final class DeleteSavedJobFailure extends JobsState {
  final String errorMessage;

  DeleteSavedJobFailure(this.errorMessage);
}
