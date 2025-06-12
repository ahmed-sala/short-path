import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:short_path/core/dialogs/show_hide_loading.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/animations/app_animation.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/career/cv_cubit.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../core/common/common_imports.dart';

class CvScreen extends StatelessWidget {
  CvScreen({
    super.key,
    this.jobId,
    this.jobDescription,
  });

  final int? jobId;
  final String? jobDescription;
  SfPdfViewer? document;

  Future<void> _loadPdf(BuildContext context, String? filePath) async {
    try {
      SfPdfViewer pdf = await SfPdfViewer.file(File(filePath!));
      document = pdf;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "${context.localization.errorLoadingCv}: $e",
        backgroundColor: Colors.red,
      );
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
        appBar: AppBar(title: Text(context.localization.yourCv)),
        body: BlocConsumer<CvCubit, CvState>(
          listener: (context, state) {
            var vm = context.read<CvCubit>();

            if (state is DownloadCvError) {
              Fluttertoast.showToast(
                msg: state.message,
                backgroundColor: Colors.red,
              );
            }
            if (state is InterviewPreparationLoading) {
              showLoading(context, 'generating interview prep...');
            }
            // Show interview prep dialog when loaded
            if (state is InterviewPreparationLoaded) {
              hideLoading();
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => InterviewPrepDialog(
                  questions: state.questions,
                  answers: state.answers,
                  onClose: () => Navigator.of(context).pop(),
                ),
              );
            }
          },
          builder: (context, state) {
            var vm = context.read<CvCubit>();

            // Loading state or PDF not yet ready
            if (state is DownloadCvLoading) {
              return Center(
                child: Lottie.asset(
                  AppAnimation.loading,
                  width: 200,
                ),
              );
            }

            // Download error UI
            if (state is DownloadCvError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.localization.pleaseTryAgainLater,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    CustomAuthButton(
                      text: context.localization.goBack,
                      onPressed: () => Navigator.pop(context),
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              );
            }

            // Fallback: no CV
            return Column(
              children: [
                // PDF viewer
                Expanded(
                  child: SfPdfViewer.file(
                    File(vm.filePath!),
                  ),
                ),

                // Interview Prep button
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: CustomAuthButton(
                      text: 'Generate Interview Questions',
                      onPressed: () {
                        if (jobId != null) {
                          vm.generateInterviewPreparationByJobId(jobId!);
                        } else if (jobDescription != null) {
                          vm.generateInterviewPreparationByJobDescription(
                            jobDescription!,
                          );
                        }
                      },
                      color: AppColors.primaryColor),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Dialog that embeds your InterviewPreparationScreen design
class InterviewPrepDialog extends StatelessWidget {
  final List<String> questions;
  final List<String> answers;
  final String? jobTitle;
  final VoidCallback onClose;

  const InterviewPrepDialog({
    Key? key,
    required this.questions,
    required this.answers,
    this.jobTitle,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          // Scrollable content with cards
          Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  questions.length,
                  (i) {
                    final q = questions[i];
                    final a = i < answers.length
                        ? answers[i]
                        : 'No answer available.';
                    return Card(
                      margin: EdgeInsets.only(bottom: 16.h),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              q,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              a,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Close button
          Positioned(
            top: 4.h,
            right: 4.w,
            child: IconButton(
              icon: Icon(Icons.close, size: 28.sp),
              onPressed: onClose,
            ),
          ),

          // Optional title
          if (jobTitle != null)
            Positioned(
              top: 12.h,
              left: 24.w,
              right: 24.w,
              child: Center(
                child: Text(
                  jobTitle!,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
