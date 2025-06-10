import 'dart:io';

// import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
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
            var viewModel = context.read<CvCubit>();
            if (state is DownloadCvError) {
              Fluttertoast.showToast(
                msg: state.message,
                backgroundColor: Colors.red,
              );
            }
            if (state is DownloadCvSuccess) {
              _loadPdf(context, viewModel.filePath);
            }
          },
          builder: (context, state) {
            print('jobDescription: $jobDescription');
            var viewModel = context.read<CvCubit>();
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
                children: [
                  Text(
                    context.localization.pleaseTryAgainLater,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomAuthButton(
                      text: context.localization.goBack,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: AppColors.primaryColor)
                ],
              ));
            }
            if (state is DownloadCvSuccess) {
              return SfPdfViewer.file(
                File(viewModel.filePath!),
              );
            }
            return Center(
              child: Text(
                context.localization.noCvAvailable,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
