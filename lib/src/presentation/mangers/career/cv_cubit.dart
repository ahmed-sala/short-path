import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../core/common/api/api_result.dart';
import '../../../data/api/core/error/error_handler.dart';
import '../../../data/dto_models/career/interview_preparation_dto.dart';
import '../../../domain/usecases/career/career_usecase.dart';

part 'cv_state.dart';

@injectable
class CvCubit extends Cubit<CvState> {
  final CareerUsecase _careerUsecase;

  CvCubit(this._careerUsecase) : super(CvInitial());
  String? filePath;
  List<String> interviewQuestions = [];
  List<String> interviewAnswers = [];
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

  Future<void> generateInterviewPreparationByJobId(int jobId) async {
    try {
      emit(InterviewPreparationLoading());
      final result = await _careerUsecase.interviewPreparationById(jobId);
      switch (result) {
        case Success<InterviewPreparationDto>():
          _parseInterviewPreparation(result.data!.interviewPreparation!);
          print('Interview preparation loaded successfully');
          print('Questions: $interviewQuestions');
          print('Answers: $interviewAnswers');
          emit(InterviewPreparationLoaded(
            questions: interviewQuestions,
            answers: interviewAnswers,
          ));
          break;
        case Failures():
          emit(InterviewPreparationError(result.exception.toString()));
          break;
      }
    } catch (e) {
      emit(InterviewPreparationError(e.toString()));
    }
  }

  Future<void> generateInterviewPreparationByJobDescription(
      String jobDescription) async {
    try {
      emit(InterviewPreparationLoading());
      final result = await _careerUsecase
          .interviewPreparationByDescription(jobDescription);
      switch (result) {
        case Success<InterviewPreparationDto>():
          _parseInterviewPreparation(result.data!.interviewPreparation!);
          print('Interview preparation loaded successfully');
          print('Questions: $interviewQuestions');
          print('Answers: $interviewAnswers');
          emit(InterviewPreparationLoaded(
            questions: interviewQuestions,
            answers: interviewAnswers,
          ));
          break;
        case Failures():
          emit(InterviewPreparationError(result.exception.toString()));
          break;
      }
    } catch (e) {
      emit(InterviewPreparationError(e.toString()));
    }
  }

  /// Single-line aware parser: splits on numbering and then uses punctuation to separate Q/A
  void _parseInterviewPreparation(String raw) {
    interviewQuestions.clear();
    interviewAnswers.clear();

    // Trim any leading text before first number
    final first = RegExp(r'\d+\.').firstMatch(raw);
    final content = first != null ? raw.substring(first.start) : raw;

    // Split into blocks at each 'digit+.' marker
    final blocks = content.split(RegExp(r'(?=\d+\.)'));

    for (var block in blocks) {
      final b = block.trim();
      if (b.isEmpty) continue;

      // Remove leading number and optional bold markers
      var text = b.replaceFirst(RegExp(r'^\d+\.\s*'), '');
      text = text.replaceAll(RegExp(r'\*\*'), '').trim();

      // Find end of question by first question mark or question-colon
      int splitIndex = -1;
      final qm = text.indexOf('?');
      if (qm != -1) {
        splitIndex = qm + 1;
      } else {
        // fallback: before first period if no '?'
        final pd = text.indexOf('. ');
        if (pd != -1) splitIndex = pd + 1;
      }

      String question;
      String answer;

      if (splitIndex > 0 && splitIndex < text.length) {
        question = text.substring(0, splitIndex).trim();
        answer = text.substring(splitIndex).trim();
      } else {
        // no clear split: whole text as question, empty answer
        question = text;
        answer = '';
      }

      interviewQuestions.add(question);
      interviewAnswers.add(answer);
    }
  }
}
