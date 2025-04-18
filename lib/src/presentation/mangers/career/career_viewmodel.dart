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
  CareerViewmodel(
    this._careerUsecase,
  ) : super(CareerInitial());
  String? coverSheet;
  TextEditingController jobDescribtion = TextEditingController();

  Future<void> generateCoverSheet() async {
    try {
      emit(GenerateCoverSheetLoading());
      final result =
          await _careerUsecase.generateCoverSheet(jobDescribtion.text);
      switch (result) {
        case Success<String?>():
          coverSheet = result.data;
          emit(GenerateCoverSheetSuccess());
        case Failures<String?>():
          var errorMessage =
              ErrorHandler.fromException(result.exception).errorMessage;
          emit(GenerateCoverSheetError(errorMessage));
          break;
      }
    } catch (e) {
      emit(GenerateCoverSheetError(e.toString()));
    }
  }
}
