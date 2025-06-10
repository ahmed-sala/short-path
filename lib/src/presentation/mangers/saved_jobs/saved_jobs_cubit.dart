import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:short_path/src/domain/usecases/home/home_usecase.dart';

import '../../../../core/common/api/api_result.dart';
import '../../../data/api/core/error/error_handler.dart';
import '../../../domain/entities/home/jobs_entity.dart';

part 'saved_jobs_state.dart';

@injectable
class SavedJobsCubit extends Cubit<SavedJobsState> {
  HomeUsecase _homeUsecase;
  SavedJobsCubit(this._homeUsecase) : super(SavedJobsInitial());
  List<ContentEntity>? savedJobs = [];

  Future<void> getSavedJobs() async {
    emit(SavedJobsLoading());
    var result = await _homeUsecase.getFavoriteJobs();
    switch (result) {
      case Success<List<ContentEntity>?>():
        savedJobs = result.data ?? [];
        emit(SavedJobsLoaded());
        break;
      case Failures<List<ContentEntity>?>():
        var errorMessages = ErrorHandler.fromException(result.exception);
        emit(SavedJobsError(errorMessages.errorMessage));
        break;
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
