import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/api/core/api_request_model/job_filter_request.dart';
import 'package:short_path/src/data/api/core/error/error_handler.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';
import 'package:short_path/src/domain/usecases/home/home_usecase.dart';

import '../../../domain/entities/home/jobs_entity.dart';

part 'home_state.dart';

@injectable
class HomeViewmodel extends Cubit<HomeState> {
  HomeUsecase _homeUsecase;
  HomeViewmodel(
    this._homeUsecase,
  ) : super(HomeInitial());
  AppUser? appUser;

  List<ContentEntity>? jobs;

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

  Future<void> getAllJobs() async {
    try {
      emit(JobsLoading());
      var result = await _homeUsecase.getAllJobs(
        term: '',
        page: 0,
        sort: 'title,asc',
        size: 5,
        jobFilterRequest: JobFilterRequest(),
      );
      switch (result) {
        case Success<JobEntity?>():
          jobs = result.data?.content;

          emit(JobsLoaded(jobs));
          break;
        case Failures<JobEntity?>():
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
