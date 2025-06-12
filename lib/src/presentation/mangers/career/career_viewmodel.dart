import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/api/core/error/error_handler.dart';
import 'package:short_path/src/domain/entities/career/cover_sheet_entity.dart';
import 'package:short_path/src/domain/usecases/career/career_usecase.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/dto_models/career/interview_preparation_dto.dart';

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

  List<String> interviewQuestions = [];
  List<String> interviewAnswers = [];

  Future<void> generateCoverSheet() async {
    try {
      emit(GenerateCoverSheetLoading());
      final result = await _careerUsecase.generateCoverSheet(
          jobDescription: jobDescribtion.text);
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
