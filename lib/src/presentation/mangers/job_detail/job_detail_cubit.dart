import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../core/common/api/api_result.dart';
import '../../../data/api/core/error/error_handler.dart';
import '../../../data/dto_models/career/interview_preparation_dto.dart';
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

  List<String> interviewQuestions = [];
  List<String> interviewAnswers = [];

  Future<void> generateCoverSheet(int jobId) async {
    try {
      emit(GenerateCoverSheetLoading());
      final result = await _careerUsecase.generateCoverSheet(jobId: jobId);
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

  void _parseInterviewPreparation(String raw) {
    interviewQuestions.clear();
    interviewAnswers.clear();

    // Q: ... A: ... pattern
    final usesQAFormat = RegExp(r'Q:\s*.+?A:\s*').hasMatch(raw);

    if (usesQAFormat) {
      final qaRegex =
          RegExp(r'Q:\s*(.+?)\s*A:\s*(.+?)(?=(\s*Q:)|$)', dotAll: true);
      final matches = qaRegex.allMatches(raw);

      for (final match in matches) {
        final question = match.group(1)?.trim() ?? '';
        final answer = match.group(2)?.trim() ?? '';
        if (question.isNotEmpty && question != '1') {
          interviewQuestions.add(question);
          interviewAnswers.add(answer);
        }
      }
      return;
    }

    // Handle bolded numbered format like **1. Question?** Answer
    final boldBlocks = raw.split(RegExp(r'(?=\*\*\d+\.\s)'));
    if (boldBlocks.length > 1) {
      for (var block in boldBlocks) {
        block = block.trim();
        if (block.isEmpty) continue;

        final match = RegExp(r'\*\*\d+\.\s*(.+?\?)\*\*\s*(.*)', dotAll: true)
            .firstMatch(block);

        if (match != null) {
          final question = match.group(1)?.trim() ?? '';
          final answer = match.group(2)?.trim() ?? '';
          if (question.isNotEmpty && question != '1') {
            interviewQuestions.add(question);
            interviewAnswers.add(answer);
          }
        }
      }
      return;
    }

    // Handle plain numbered format like 1. Question? Answer
    final first = RegExp(r'\d+\.').firstMatch(raw);
    final content = first != null ? raw.substring(first.start) : raw;
    final plainBlocks = content.split(RegExp(r'(?=\d+\.\s)'));

    for (var block in plainBlocks) {
      block = block.trim();
      if (block.isEmpty) continue;

      // Remove numbering like "1." or "1. "
      var text = block.replaceFirst(RegExp(r'^\d+\.\s*'), '');
      text = text.replaceAll(RegExp(r'\*\*'), '').trim();

      // Find end of question by first '?', else by first '. '
      int splitIndex = text.indexOf('?');
      if (splitIndex == -1) splitIndex = text.indexOf('. ');
      if (splitIndex != -1) splitIndex += 1;

      String question, answer;
      if (splitIndex > 0 && splitIndex < text.length) {
        question = text.substring(0, splitIndex).trim();
        answer = text.substring(splitIndex).trim();
      } else {
        question = text.trim();
        answer = '';
      }

      if (question.isNotEmpty && question != '1') {
        interviewQuestions.add(question);
        interviewAnswers.add(answer);
      }
    }
  }
}
