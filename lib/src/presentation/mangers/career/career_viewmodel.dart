import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/api/core/error/error_handler.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';
import 'package:short_path/src/domain/usecases/career/career_usecase.dart';
import 'package:short_path/src/domain/usecases/home/home_usecase.dart';

part 'career_state.dart';

@injectable
class CareerViewmodel extends Cubit<CareerState> {
  CareerUsecase _careerUsecase;
  HomeUsecase _homeUsecase;
  CareerViewmodel(this._careerUsecase, this._homeUsecase)
      : super(CareerInitial());
  String? filePath;
  AppUser? appUser;
  String? coverSheet;
  TextEditingController jobDescribtion = TextEditingController();
  Future<void> downloadFile() async {
    try {
      emit(DownloadCvLoading());
      _getUserInfo();
      final result = await _careerUsecase.downloadFile();
      switch (result) {
        case Success<Stream<Uint8List>>():
          Directory directory;
          if (Platform.isAndroid) {
            directory = Directory('/storage/emulated/0/Download');
          } else {
            directory = await getApplicationDocumentsDirectory();
          }

          String filePath =
              path.join(directory.path, '${appUser?.firstName} cv.pdf');
          File file = File(filePath);

          IOSink sink = file.openWrite();
          await for (var chunk in result.data!) {
            // Write the chunk to the file
            sink.add(chunk);
          }
          await sink.close();
          this.filePath = filePath;
          emit(DownloadCvSuccess());
        case Failures<Stream<Uint8List>>():
          var errorMessage =
              ErrorHandler.fromException(result.exception).errorMessage;
          emit(DownloadCvError(errorMessage));
          break;
      }
    } catch (e) {
      emit(DownloadCvError(e.toString()));
    }
  }

  Future<void> _getUserInfo() async {
    try {
      final result = await _homeUsecase.invoke();
      switch (result) {
        case Success<AppUser?>():
          appUser = result.data;
          break;
        case Failures<AppUser?>():
          var errorMessage =
              ErrorHandler.fromException(result.exception).errorMessage;
          emit(DownloadCvError(errorMessage));
          break;
      }
    } catch (e) {}
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
