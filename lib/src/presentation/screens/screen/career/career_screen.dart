import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/career/career_viewmodel.dart';
import 'package:short_path/src/presentation/screens/screen/career/widgets/create_cv_handle.dart';
import 'package:short_path/src/presentation/screens/screen/career/widgets/tip_section_widget.dart';
import 'package:short_path/src/presentation/shared_widgets/buttons_section_widget.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../../config/helpers/shared_pref/shared_pre_keys.dart';
import '../../../../../config/routes/routes_name.dart';
import '../../../../../core/dialogs/awesome_dialoge.dart';
import '../../../../../core/functions/send_email.dart';
import 'cover_sheet_screen.dart';

class CareerScreen extends StatelessWidget {
  const CareerScreen({super.key});

  static const Color primaryColor = Color(0xFF022D4F);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CareerViewmodel>(),
      child: BlocListener<CareerViewmodel, CareerState>(
        listener: (context, state) async {
          final vm = context.read<CareerViewmodel>();
          if (state is GenerateCoverSheetLoading) {
            EasyLoading.show(status: 'Generating cover sheet...');
          } else if (state is GenerateCoverSheetSuccess) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Cover sheet ready!');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CoverSheetScreen(
                  response: vm.coverSheet,
                  sendEmail: () => EmailHandler.sendEmails(
                    vm.coverSheet,
                    vm.emailSubject,
                    vm.companyEmail,
                  ),
                ),
              ),
            );
          } else if (state is GenerateCoverSheetError) {
            EasyLoading.dismiss();
            Fluttertoast.showToast(
              msg: state.message,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
            );
          }
        },
        child: Builder(
          builder: (context) {
            final vm = context.read<CareerViewmodel>();
            var isHaveCv =
                getIt<SharedPreferences>().getBool(SharedPrefKeys.completeCv) ??
                    false;
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Craft Your Dream Career',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter a job description to generate a tailored CV or cover sheet that stands out.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Describe the Job Role',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: primaryColor),
                        ),
                        child: TextFormField(
                          controller: vm.jobDescribtion,
                          maxLines: 6,
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            labelText: 'Job Description',
                            labelStyle: TextStyle(
                              color: primaryColor.withOpacity(0.6),
                            ),
                            hintText:
                                'E.g., Software Engineer at a tech startup...',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: const Icon(
                              Icons.work_outline,
                              color: primaryColor,
                              size: 24,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Choose Your Action',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 12),
                      ButtonsSectionWidget(
                        onGenerateCoverSheetTap: () {
                          if (vm.jobDescribtion.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: 'Please add a job description.',
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                            );
                          } else if (!isHaveCv) {
                            print('No CV found, prompting user to create one');
                            showCustomDialog(context,
                                title: 'make cv',
                                message: 'Please make your cv', onConfirm: () {
                              getIt<SharedPreferences>()
                                  .setBool(SharedPrefKeys.completeCv, true);
                              navKey.currentState?.pushNamedAndRemoveUntil(
                                RoutesName.profile,
                                (Route<dynamic> route) => false,
                              );
                            });
                          } else {
                            print('have cv $isHaveCv');
                            vm.generateCoverSheet();
                          }
                        },
                        onGenerateCvTap: () {
                          if (vm.jobDescribtion.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: 'Please add a job description.',
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                            );
                          } else if (!isHaveCv) {
                            showCustomDialog(context,
                                title: 'make cv',
                                message: 'Please make your cv', onConfirm: () {
                              getIt<SharedPreferences>()
                                  .setBool(SharedPrefKeys.completeCv, true);
                              navKey.currentState?.pushNamedAndRemoveUntil(
                                RoutesName.profile,
                                (Route<dynamic> route) => false,
                              );
                            });
                          } else {
                            handleCreateCV(
                              context,
                              jobDescription: vm.jobDescribtion.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      const TipSectionWidget(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
