import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/career/career_viewmodel.dart';

class CareerScreen extends StatelessWidget {
  const CareerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CareerViewmodel careerViewmodel = getIt.get<CareerViewmodel>();

    return BlocProvider(
      create: (context) => careerViewmodel,
      child: BlocListener<CareerViewmodel, CareerState>(
        listener: (context, state) async {
          if (state is DownloadCvSuccess) {
            // Retrieve the application documents directory
            Directory directory = await getApplicationDocumentsDirectory();
            // Use the same file name used during download
            String filePath = '${directory.path}/file.pdf';
            // Open the downloaded file
            OpenFile.open(filePath);
          }
          // Handle error state if needed
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Career Screen')),
          body: Center(
            child: InkWell(
              onTap: () {
                careerViewmodel.downloadFile();
              },
              child: const Text('Download & Open CV'),
            ),
          ),
        ),
      ),
    );
  }
}
