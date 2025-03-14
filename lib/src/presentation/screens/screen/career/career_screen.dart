import 'dart:io';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/career/career_viewmodel.dart';

class CareerScreen extends StatefulWidget {
  const CareerScreen({super.key});

  @override
  State<CareerScreen> createState() => _CareerScreenState();
}

class _CareerScreenState extends State<CareerScreen> {
  PDFDocument? document;

  Future<void> loadPdf(String filePath) async {
    PDFDocument pdf = await PDFDocument.fromFile(File(filePath));
    setState(() {
      document = pdf;
    });
  }

  @override
  Widget build(BuildContext context) {
    final CareerViewmodel careerViewmodel = getIt.get<CareerViewmodel>();

    return BlocProvider(
      create: (context) => careerViewmodel,
      child: BlocListener<CareerViewmodel, CareerState>(
        listener: (context, state) async {
          if (state is DownloadCvSuccess) {
            Directory directory = await getApplicationDocumentsDirectory();
            await loadPdf(careerViewmodel.filePath ?? '');
            Fluttertoast.showToast(
              msg: context.localization.downloadedSuccessfully,
              backgroundColor: Colors.green,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Career Screen')),
          body: Center(
            child: document == null
                ? InkWell(
                    onTap: () {
                      careerViewmodel.downloadFile();
                    },
                    child: const Text('Download & Open CV'),
                  )
                : PDFViewer(document: document!),
          ),
        ),
      ),
    );
  }
}
