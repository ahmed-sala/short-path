import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../core/common/api/api_result.dart';
import '../../../data/api/core/error/error_handler.dart';
import '../../../domain/usecases/career/career_usecase.dart';

part 'cv_state.dart';

@injectable
class CvCubit extends Cubit<CvState> {
  final CareerUsecase _careerUsecase;

  CvCubit(this._careerUsecase) : super(CvInitial());
  String? filePath;
  Future<void> downloadFile({String? jobDescription, int? jobId}) async {
    try {
      print('jobDescription: $jobDescription');
      emit(DownloadCvLoading());
      final result = await _careerUsecase.downloadFile(
        jobDescription: jobDescription,
        jobId: jobId,
      );
      switch (result) {
        case Success<Response<ResponseBody>>():
          final response = result.data!;
          final headers = response.headers;

          final contentDisposition = headers.value('content-disposition');
          final regex = RegExp(r'filename="?([^"]+)"?');
          final match = regex.firstMatch(contentDisposition ?? '');
          final filename = match != null ? match.group(1) : 'default.pdf';

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
}
