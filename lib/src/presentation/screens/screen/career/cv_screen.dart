import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:short_path/core/styles/animations/app_animation.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/career/cv_cubit.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../job/interview_preparation_screen.dart';

class CvScreen extends StatelessWidget {
  CvScreen({
    super.key,
    this.jobId,
    this.jobDescription,
  });

  final int? jobId;
  final String? jobDescription;
  SfPdfViewer? document;

  Future<void> _loadPdf(String? filePath) async {
    try {
      document = await SfPdfViewer.file(File(filePath!));
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error loading CV: \$e",
        backgroundColor: Colors.red,
      );
    }
  }

  void _showInterviewPreparation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: getIt<CvCubit>(),
        child: InterviewPreparationScreen(
          questions: context.read<CvCubit>().interviewQuestions,
          answers: context.read<CvCubit>().interviewAnswers,
          jobTitle: jobDescription,
          jobId: jobId,
        ),
      ),
    );
    // trigger generation if not yet loaded
    if (jobId != null) {
      getIt<CvCubit>().generateInterviewPreparationByJobId(jobId!);
    } else if (jobDescription != null) {
      getIt<CvCubit>()
          .generateInterviewPreparationByJobDescription(jobDescription!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CvCubit>()
        ..downloadFile(
          jobId: jobId,
          jobDescription: jobDescription,
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your CV'),
          actions: [
            IconButton(
              icon: const Icon(Icons.question_answer),
              onPressed: () => _showInterviewPreparation(context),
              tooltip: 'Interview Prep',
            ),
          ],
        ),
        body: BlocConsumer<CvCubit, CvState>(
          listener: (context, state) {
            if (state is DownloadCvError) {
              Fluttertoast.showToast(
                msg: state.message,
                backgroundColor: Colors.red,
              );
            }
            if (state is DownloadCvSuccess) {
              _loadPdf(context.read<CvCubit>().filePath);
            }
          },
          builder: (context, state) {
            final viewModel = context.read<CvCubit>();
            if (state is DownloadCvLoading || document == null) {
              return Center(
                child: Lottie.asset(
                  AppAnimation.loading,
                  width: 200,
                ),
              );
            }
            if (state is DownloadCvError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Please try again later',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Go back'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is DownloadCvSuccess) {
              return Column(
                children: [
                  Expanded(
                    child: SfPdfViewer.file(
                      File(viewModel.filePath!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton.icon(
                      onPressed: () => _showInterviewPreparation(context),
                      icon: const Icon(Icons.question_answer),
                      label: const Text('Interview Preparation'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: Text(
                'No CV available',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            );
          },
        ),
      ),
    );
  }
}
