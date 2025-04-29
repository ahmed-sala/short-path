import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../core/common/api/api_result.dart';
import '../../../data/api/core/error/error_handler.dart';
import '../../../domain/entities/career/cover_sheet_entity.dart';
import '../../../domain/usecases/career/career_usecase.dart';
import 'job_detail_state.dart';


@injectable
class JobDetailCubit extends Cubit<JobDetailState> {
  final CareerUsecase _careerUsecase;
  JobDetailCubit(this._careerUsecase) : super(JobDetailInitial());
  String? coverSheet;
  String? companyName;
  String? companyEmail;
  String? emailSubject;
  Future<void> generateCoverSheet(int jobId) async {
    try {
      emit(GenerateCoverSheetLoading());
      final result =
      await _careerUsecase.generateCoverSheet(jobId:jobId);
      switch (result) {
        case Success<CoverSheetEntity?>():
          var coverSheetResponse = result.data;
          coverSheet = coverSheetResponse?.coverSheet;
          companyName = coverSheetResponse?.companyName;
          companyEmail = coverSheetResponse?.companyEmail;
          emailSubject = coverSheetResponse?.emailSubject;

          emit(GenerateCoverSheetSuccess());
        case Failures<CoverSheetEntity?>():
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
