import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/api/core/error/error_handler.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';
import 'package:short_path/src/domain/usecases/home/home_usecase.dart';

import '../../../domain/entities/home/job_entity.dart';

part 'home_state.dart';

@injectable
class HomeViewmodel extends Cubit<HomeState> {
  HomeUsecase _homeUsecase;
  HomeViewmodel(
    this._homeUsecase,
  ) : super(HomeInitial());
  AppUser? appUser;
  List<JobEntity>? jobs;

  List<JobEntity>? fullTimeJobs;
  List<JobEntity>? partTimeJobs;
  List<JobEntity>? contractorJobs;

  void getUserData() async {
    emit(UserDataLoading());
    var result = await _homeUsecase.invoke();
    switch (result) {
      case Success<AppUser?>():
        appUser = result.data;
        emit(UserDataLoaded(appUser));
        break;
      case Failures<AppUser?>():
        var errorMessages = ErrorHandler.fromException(result.exception);
        if (errorMessages.code == 403) {
          emit(SessionExpired());
          break;
        }
        emit(UserDataError(errorMessages.errorMessage));
    }
  }

  void getAllJobs() async {
    try {
      emit(JobsLoading());
      var result = await _homeUsecase.getAllJobs();
      switch (result) {
        case Success<List<JobEntity>?>():
          jobs = result.data;
          fullTimeJobs = jobs
              ?.where((job) =>
                  job.employmentType == "Full-time" ||
                  job.employmentType == "Full-time and Part-time")
              .toList();
          partTimeJobs = jobs
              ?.where((job) =>
                  job.employmentType == "Part-time" ||
                  job.employmentType == "Full-time and Part-time")
              .toList();
          contractorJobs =
              jobs?.where((job) => job.employmentType == "Contractor").toList();
          emit(JobsLoaded(jobs));
          break;
        case Failures<List<JobEntity>?>():
          var errorMessages = ErrorHandler.fromException(result.exception);
          if (errorMessages.code == 403) {
            emit(SessionExpired());
            break;
          }
          emit(JobsError(errorMessages.errorMessage));
          break;
      }
    } catch (e) {
      emit(JobsError(e.toString()));
    }
  }
}
