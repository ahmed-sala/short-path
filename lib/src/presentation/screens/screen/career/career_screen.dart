import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/career/career_viewmodel.dart';

import 'cover_sheet_screen.dart';
import 'cv_screen.dart';

class CareerScreen extends StatelessWidget {
  CareerScreen({super.key});

  final CareerViewmodel careerViewmodel = getIt<CareerViewmodel>();

  // Check if permission is already granted without prompting the user.
  Future<bool> _hasStoragePermission() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 30) {
        return await Permission.manageExternalStorage.isGranted;
      } else {
        return await Permission.storage.isGranted;
      }
    } else {
      return true;
    }
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 30) {
        var status = await Permission.manageExternalStorage.status;
        if (!status.isGranted) {
          status = await Permission.manageExternalStorage.request();
        }
        return status.isGranted;
      } else {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
        }
        return status.isGranted;
      }
    } else {
      return true;
    }
  }

  Future<void> _handleCreateCV(BuildContext context) async {
    // First check if permission is already granted.
    bool alreadyGranted = await _hasStoragePermission();
    if (alreadyGranted) {
      Fluttertoast.showToast(
        msg: "Permission already granted! Downloading file...",
        backgroundColor: Colors.green,
      );
      careerViewmodel.downloadFile();
      return;
    }

    // If not, show a dialog asking the user to grant permission.
    bool? userConfirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
              'Do you want to grant storage permission to download the file?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    if (userConfirmed == true) {
      // Request permission.
      bool permissionGranted = await _requestStoragePermission();
      if (!permissionGranted) {
        Fluttertoast.showToast(
          msg: "Storage permission is required to download the file.",
          backgroundColor: Colors.red,
        );
        return;
      }
      Fluttertoast.showToast(
        msg: "Permission granted! Downloading file...",
        backgroundColor: Colors.green,
      );
      careerViewmodel.downloadFile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => careerViewmodel,
      child: BlocListener<CareerViewmodel, CareerState>(
        listener: (context, state) async {
          if (state is DownloadCvSuccess) {
            if (careerViewmodel.filePath?.isNotEmpty ?? false) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CvScreen(filePath: careerViewmodel.filePath!),
                ),
              );
            }
          } else if (state is DownloadCvError) {
            EasyLoading.dismiss();
            Fluttertoast.showToast(
              msg: state.message,
              backgroundColor: Colors.red,
            );
          }
          if (state is GenerateCoverSheetLoading) {
            EasyLoading.show(status: 'Loading...');
          }
          if (state is GenerateCoverSheetSuccess) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess(
              'Cover sheet generated successfully!',
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CoverSheetScreen(
                  response: careerViewmodel.coverSheet,
                ),
              ),
            );
          } else if (state is GenerateCoverSheetError) {
            EasyLoading.dismiss();
            Fluttertoast.showToast(
              msg: state.message,
              backgroundColor: Colors.red,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Career Screen')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Job description text field
                TextField(
                  controller: careerViewmodel.jobDescribtion,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Job Description',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                // Buttons for "Create CV" and "Create Cover Sheet"
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (careerViewmodel.jobDescribtion.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please enter a job description.",
                            backgroundColor: Colors.red,
                          );
                        } else {
                          _handleCreateCV(context);
                        }
                      },
                      child: const Text('Create CV'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (careerViewmodel.jobDescribtion.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please enter a job description.",
                            backgroundColor: Colors.red,
                          );
                        } else {
                          careerViewmodel.generateCoverSheet();
                        }
                      },
                      child: const Text('Create Cover Sheet'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
