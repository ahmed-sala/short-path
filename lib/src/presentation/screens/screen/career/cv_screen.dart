import 'dart:io';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:short_path/core/styles/animations/app_animation.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/career/cv_cubit.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';

import '../../../../../core/common/common_imports.dart';

class CvScreen extends StatelessWidget {
  CvScreen({
    super.key,
    this.jobId,
    this.jobDescription,
  });
  final int? jobId;
  final String? jobDescription;
  PDFDocument? document;

  Future<void> _loadPdf(String? filePath) async {
    try {
      PDFDocument pdf = await PDFDocument.fromFile(File(filePath!));

      document = pdf;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error loading CV: $e",
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
        appBar: AppBar(title: const Text('Your CV')),
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
              _loadPdf(viewModel.filePath);
            }
          },
          builder: (context, state) {
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
                  const Text(
                    'please try again later',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomAuthButton(
                      text: 'Go back',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: AppColors.primaryColor)
                ],
              ));
            }
            if (state is DownloadCvSuccess) {
              return PDFViewer(
                document: document!,
                showPicker: false,
                lazyLoad: false,
              );
            }
            return const Center(
              child: Text(
                'No CV available',
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
