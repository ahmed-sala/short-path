import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/helpers/validations.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/dialogs/show_hide_loading.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/domain/entities/user_info/Certification_Entity.dart';
import 'package:short_path/src/presentation/mangers/user_info/Certification/certification_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/Certification/certification_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/certification/certification_list.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';
import 'package:short_path/src/presentation/shared_widgets/date_input_feild.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../shared_widgets/progress_bar.dart';
import '../../../widgets/user info/profile/header_widget.dart';

class CertificationScreen extends StatelessWidget {
  CertificationScreen({super.key});
  CertificationViewmodel viewModel = getIt<CertificationViewmodel>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(

        body: Directionality(
          textDirection: TextDirection.ltr,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              child: BlocConsumer<CertificationViewmodel, CertificationState>(
                listener: (context, state) {
                  if (state is AddCertificationsLoading) {
                    showLoading(
                        context, context.localization.addingCertifications);
                  } else if (state is AddCertificationsSuccess) {
                    navKey.currentState!.pushNamedAndRemoveUntil(
                        RoutesName.additionalinfo, (route) => false);
                  } else if (state is AddCertificationsFailure) {
                    showAwesomeDialog(context,
                        title: context.localization.error,
                        desc: state.message,
                        onOk: () {},
                        dialogType: DialogType.error);
                  } else if (state is ExpirationDateChanged) {
                    viewModel.selectedExpirationDate = state.date;
                  }
                },
                listenWhen: (previous, current) {
                  if (previous is AddCertificationsLoading ||
                      current is AddCertificationsFailure) {
                    hideLoading();
                  }
                  return current is! CertificationInitialState;
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(50),
                      const Center(child: HeaderWidget()),
                      StepProgressBar(currentStep: 6),
                      verticalSpace(22),
                      Form(
                        key: viewModel.formKey,
                        onChanged: viewModel.validateColorButton,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                                hintText:
                                    context.localization.enterCertificationName,
                                keyboardType: TextInputType.text,
                                controller:
                                    viewModel.certificationNameController,
                                labelText:
                                    context.localization.certificationName,
                                validator: (value) {
                                  return validateCertificationName(value);
                                }),
                            verticalSpace(20),
                            CustomTextFormField(
                              hintText:
                                  context.localization.enterIssuingOrganization,
                              keyboardType: TextInputType.text,
                              controller:
                                  viewModel.issuingOrganizationController,
                              labelText:
                                  context.localization.issuingOrganization,
                              validator: (value) {
                                return validateIssuingOrganization(value);
                              },
                            ),
                            verticalSpace(20),
                            DateInputField(
                              selectedDate: viewModel.selectedDateEarned,
                              onDateSelected: viewModel.setDateEarned,
                              labelText: context.localization.dateEarned,
                            ),
                            verticalSpace(20),
                            DateInputField(
                              selectedDate: viewModel.selectedExpirationDate,
                              onDateSelected: viewModel.setExpirationDate,
                              labelText: context.localization.expirationDate,
                            ),
                            verticalSpace(20),
                            CustomAuthButton(
                              text: context.localization.addCertification,
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
                        CertificationList(
                            certifications: viewModel.certifications,
                            onRemove: (CertificationEntity certification) {
                              viewModel.removeCertification(
                                certification,
                              );
                            },
                            onUndo: (CertificationEntity certification) {
                              viewModel.addCertificationBack(
                                certification,
                              );
                            }),
                      // NEXT Button
                      CustomAuthButton(
                        text: context.localization.next,
                        onPressed: viewModel.certifications.isNotEmpty
                            ? () {
                                viewModel.next();
                              }
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
      ),
    );
  }
}
