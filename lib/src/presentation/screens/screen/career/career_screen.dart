import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/career/career_viewmodel.dart';

import '../../widgets/career/create_cv_handle.dart';
import 'cover_sheet_screen.dart';
import 'cv_screen.dart';

class CareerScreen extends StatelessWidget {
  CareerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CareerViewmodel>(),
      child: BlocListener<CareerViewmodel, CareerState>(
        listener: (context, state) async {
          var careerViewmodel = context.read<CareerViewmodel>();

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
                  sendEmail: () {
                    careerViewmodel.sendEmail();
                  },
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
            child: Builder(builder: (context) {
              var careerViewmodel = context.read<CareerViewmodel>();
              return Column(
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
                            handleCreateCV(context, careerViewmodel);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CvScreen(),
                              ),
                            );
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
              );
            }),
          ),
        ),
      ),
    );
  }
}
