import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import '../../../../mangers/infromation_gathering/Certification/certification_state.dart';
import '../../../../mangers/infromation_gathering/Certification/certification_viewmodel.dart';
import '../../../../shared_widgets/custom_auth_button.dart';
import '../../../../shared_widgets/custom_auth_text_feild.dart';

class CertificationScreen extends StatelessWidget {
  const CertificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CertificationViewmodel viewModel = getIt.get<CertificationViewmodel>();
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Certifications'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: BlocConsumer<CertificationViewmodel, CertificationState>(
              listener: (context, state) {
                if (state is CertificationUpdated) {
                  // Handle any actions after adding/removing certification
                }
              },
              buildWhen: (previous, current) =>
              current is CertificationInitialState ||
                  current is ValidateColorButtonState ||
                  current is CertificationUpdated,
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Form for Adding Certification
                    Form(
                      key: viewModel.formKey,
                      onChanged: viewModel.validateColorButton,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            hintText: 'Enter Certification Name',
                            keyboardType: TextInputType.text,
                            controller: viewModel.certificationNameController,
                            labelText: 'Certification Name',
                            validator: viewModel.validateCertificationName,
                          ),
                          verticalSpace(20),
                          CustomTextFormField(
                            hintText: 'Enter Issuing Organization',
                            keyboardType: TextInputType.text,
                            controller: viewModel.issuingOrganizationController,
                            labelText: 'Issuing Organization',
                            validator: viewModel.validateIssuingOrganization,
                          ),
                          verticalSpace(20),
                          GestureDetector(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2030),
                              );
                              if (pickedDate != null) {
                                viewModel.setDateEarned(pickedDate);
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F4F4),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              height: 70.h,
                              padding: const EdgeInsets.only(top: 20),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Date Earned',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  viewModel.selectedDateEarned != null
                                      ? DateFormat('M/d/yyyy')
                                      .format(viewModel.selectedDateEarned!)
                                      : 'Select Date',
                                  style: TextStyle(
                                    color: viewModel.selectedDateEarned == null
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          verticalSpace(20),
                          GestureDetector(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2030),
                              );
                              if (pickedDate != null) {
                                viewModel.setExpirationDate(pickedDate);
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F4F4),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              height: 70.h,
                              padding: const EdgeInsets.only(top: 20),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Expiration Date',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  viewModel.selectedExpirationDate != null
                                      ? DateFormat('M/d/yyyy')
                                      .format(viewModel.selectedExpirationDate!)
                                      : 'Select Date',
                                  style: TextStyle(
                                    color: viewModel.selectedExpirationDate == null
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          verticalSpace(20),
                          CustomAuthButton(
                            text: 'Add Certification',
                            onPressed: () {
                              viewModel.addCertification();
                              // Clear text fields after adding certification
                              viewModel.certificationNameController.clear();
                              viewModel.issuingOrganizationController.clear();
                              viewModel.selectedDateEarned = null;
                              viewModel.selectedExpirationDate = null;
                            },
                            color: AppColors.primaryColor,
                          ),
                          verticalSpace(30),
                        ],
                      ),
                    ),
                    // Display the List of Certifications
                    if (viewModel.certifications.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Added Certifications:',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          verticalSpace(10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.certifications.length,
                            itemBuilder: (context, index) {
                              final certification = viewModel.certifications[index];

                              return Card(
                                margin: EdgeInsets.only(bottom: 10.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: AppColors.primaryColor, width: 1),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        certification.certificationName,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      verticalSpace(5),
                                      Text(
                                        'Issued by: ${certification.issuingOrganization}',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                      verticalSpace(5),
                                      Text(
                                        'Date Earned: ${certification.dateEarned}',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                      verticalSpace(5),
                                      Text(
                                        'Expiration Date: ${certification.expirationDate}',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                      verticalSpace(10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
                                              if (scaffoldMessenger == null) {
                                                debugPrint('ScaffoldMessenger not found.');
                                                return;
                                              }

                                              scaffoldMessenger.hideCurrentSnackBar();
                                              viewModel.removeCertification(certification);

                                              scaffoldMessenger.showSnackBar(
                                                SnackBar(
                                                  content: Text('${certification.certificationName} removed!'),
                                                  backgroundColor: Colors.red,
                                                  action: SnackBarAction(
                                                    label: 'Undo',
                                                    onPressed: () {
                                                      scaffoldMessenger.hideCurrentSnackBar();
                                                      viewModel.addCertificationBack(certification);
                                                      scaffoldMessenger.showSnackBar(
                                                        SnackBar(
                                                          content: Text('${certification.certificationName} restored!'),
                                                          backgroundColor: Colors.green,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    // NEXT Button
                    CustomAuthButton(
                      text: 'NEXT',
                      onPressed: viewModel.certifications.isNotEmpty
                          ? () {}
                          : null,
                      color: viewModel.certifications.isNotEmpty
                          ? AppColors.primaryColor
                          : const Color(0xFF5C6673),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
