import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/api/core/error/error_handler.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';
import 'package:short_path/src/domain/usecases/career/career_usecase.dart';

part 'career_state.dart';

@injectable
class CareerViewmodel extends Cubit<CareerState> {
  CareerUsecase _careerUsecase;
  CareerViewmodel(
    this._careerUsecase,
  ) : super(CareerInitial());
  String? filePath;
  AppUser? appUser;
  String? coverSheet;
  TextEditingController jobDescribtion = TextEditingController();
  Future<void> downloadFile() async {
    try {
      emit(DownloadCvLoading());
      final result = await _careerUsecase.downloadFile();
      switch (result) {
        case Success<Response<ResponseBody>>():
          final response = result.data!;
          final headers = response.headers;

          final contentDisposition = headers.value('content-disposition');
          final regex = RegExp(r'filename="?([^"]+)"?');
          final match = regex.firstMatch(contentDisposition ?? '');
          final filename = match != null ? match.group(0) : 'default.pdf';

          Directory directory;
          if (Platform.isAndroid) {
            directory = Directory('/storage/emulated/0/Download');
          } else {
            directory = await getApplicationDocumentsDirectory();
          }

          final filePath = path.join(directory.path, filename!);
          final file = File(filePath);
          final sink = file.openWrite();

          await response.data!.stream.forEach((chunk) {
            sink.add(chunk);
          });

          await sink.close();
          this.filePath = filePath;

          emit(DownloadCvSuccess());

        case Failures<Response<ResponseBody>>():
          var errorMessage =
              ErrorHandler.fromException(result.exception).errorMessage;
          emit(DownloadCvError(errorMessage));
          break;
      }
    } catch (e) {
      emit(DownloadCvError(e.toString()));
    }
  }

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
