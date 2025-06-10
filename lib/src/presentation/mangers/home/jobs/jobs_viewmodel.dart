import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/src/data/api/core/api_request_model/job_filter_request.dart';

import '../../../../../core/common/api/api_result.dart';
import '../../../../../core/common/common_imports.dart';
import '../../../../data/api/core/error/error_handler.dart';
import '../../../../domain/entities/home/jobs_entity.dart';
import '../../../../domain/usecases/home/home_usecase.dart';

part 'jobs_state.dart';

@injectable
class JobsViewmodel extends Cubit<JobsState> {
  final HomeUsecase _homeUsecase;
  JobsViewmodel(this._homeUsecase) : super(AllJobsInitial());

  List<ContentEntity> jobs = [];
  int currentPage = 0;
  final int pageSize = 10;
  int totalPages = 1;
  TextEditingController searchController = TextEditingController();

  /// Fetch jobs for a specific page.
  Future<void> getJobsForPage(int page) async {
    try {
      emit(AllJobsLoading());
      // Call your API with the selected page
      var result = await _homeUsecase.getAllJobs(
        term: searchController.text,
        page: page,
        sort: '',
        size: pageSize,
        jobFilterRequest: JobFilterRequest(),
      );
      switch (result) {
        case Success<JobEntity?>():
          var jobData = result.data;
          jobs = jobData?.content ?? [];
          totalPages = jobData?.totalPages ?? 1;
          currentPage = page;
          emit(AllJobsLoaded(jobs));
          break;
        case Failures<JobEntity?>():
          var errorMessages = ErrorHandler.fromException(result.exception);
          if (errorMessages.code == 403) {
            emit(SessionExpired());
            break;
          }
          emit(AllJobsError(errorMessages.errorMessage));
          break;
      }
    } catch (e) {
      emit(AllJobsError(e.toString()));
    }
  }

  Future<void> saveJobToFavorite(ContentEntity contentEntity) async {
    emit(SavedJobsLoading());
    final result = await _homeUsecase.saveJobToFavorite(contentEntity);
    switch (result) {
      case Success<void>():
        emit(SaveJobsSuccess());
      case Failures<void>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;

        emit(SavedJobsFailure(errorMessages));
    }
  }

  Future<void> removeJobFromFavorite(ContentEntity contentEntity) async {
    emit(SavedJobsLoading());
    final result = await _homeUsecase.removeJobFromFavorite(contentEntity);
    switch (result) {
      case Success<void>():
        emit(DeleteSavedJobSuccess());
      case Failures<void>():
        var errorMessages =
            ErrorHandler.fromException(result.exception).errorMessage;

        emit(SavedJobsFailure(errorMessages));
    }
  }
}
