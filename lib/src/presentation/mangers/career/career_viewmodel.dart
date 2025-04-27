import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/api/core/error/error_handler.dart';
import 'package:short_path/src/domain/entities/career/cover_sheet_entity.dart';
import 'package:short_path/src/domain/usecases/career/career_usecase.dart';
import 'package:url_launcher/url_launcher.dart';

part 'career_state.dart';

@injectable
class CareerViewmodel extends Cubit<CareerState> {
  final CareerUsecase _careerUsecase;
  CareerViewmodel(
    this._careerUsecase,
  ) : super(CareerInitial());
  String? coverSheet;
  String? companyName;
  String? companyEmail;
  String? emailSubject;
  TextEditingController jobDescribtion = TextEditingController();

  Future<void> generateCoverSheet() async {
    try {
      emit(GenerateCoverSheetLoading());
      final result =
          await _careerUsecase.generateCoverSheet(jobDescribtion.text);
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

  void sendEmail() async {
    final rawBody = coverSheet!
        // normalize line endings
        .replaceAll('\r\n', '\n')
        .replaceAll('\n', '\r\n')
        // drop any **…** pairs
        .replaceAllMapped(RegExp(r'\*\*(.*?)\*\*'), (m) => m.group(1)!);

    final mailtoUri = Uri.parse('mailto:ahmeds66210@gmail.com'
        '?subject=${Uri.encodeComponent(emailSubject!)}'
        '&body=${Uri.encodeComponent(rawBody)}');

    await launchUrl(mailtoUri);
  }
}
