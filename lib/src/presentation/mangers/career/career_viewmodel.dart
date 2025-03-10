import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/api/core/error/error_handler.dart';
import 'package:short_path/src/domain/usecases/career/career_usecase.dart';

part 'career_state.dart';

@injectable
class CareerViewmodel extends Cubit<CareerState> {
  CareerUsecase _careerUsecase;
  CareerViewmodel(this._careerUsecase) : super(CareerInitial());

  Future<void> downloadFile() async {
    try {
      emit(DownloadCvLoading());
      final result = await _careerUsecase.downloadFile();
      switch (result) {
        case Success<void>():
          emit(DownloadCvSuccess());
          break;
        case Failures<void>():
          var errorMesssage =
              ErrorHandler.fromException(result.exception).errorMessage;
          emit(DownloadCvError(errorMesssage));
          break;
      }
    } catch (e) {
      emit(DownloadCvError(e.toString()));
    }
  }
}
