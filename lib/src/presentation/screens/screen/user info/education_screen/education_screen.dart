// education_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/education/education_header.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_drop_downButton_form_field.dart';
import 'package:short_path/src/presentation/shared_widgets/date_input_feild.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var educationViewmodel = context.read<EducationViewmodelNew>();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
        child: BlocConsumer<EducationViewmodelNew, EducationState>(
          listener: (context, state) {
            if (state is UpdateSelectedDateState) {
              educationViewmodel.selectedDate =
                  state.selectedDate; // Update UI when state changes
            }
          },
          builder: (context, state) {
            return Form(
              key: educationViewmodel.formKey,
              onChanged: educationViewmodel.validateColorButton,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: EducationHeader(
                      title: context.localization.addYourEducation,
                    ),
                  ),
                  verticalSpace(30),
                  CustomTextFormField(
                    keyboardType: TextInputType.text,
                    hintText: context.localization.enterYourInstitutionName,
                    controller: educationViewmodel.institutionName,
                    labelText: context.localization.institutionName,
                    validator: (val) => val == null || val.isEmpty
                        ? context.localization.pleaseEnterYourInstitutionName
                        : null,
                  ),
                  verticalSpace(20),
                  // Row for Degree Dropdown and Field of Study
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropdownButtonFormField(
                          labelText: context.localization.role,
                          hintText: context.localization.selectRole,
                          value: educationViewmodel.selectedDegree,
                          items: [
                            context.localization.associates,
                            context.localization.bachelors,
                            context.localization.masters,
                            context.localization.doctorate
                          ]
                              .map(
                                (jobLocation) => DropdownMenuItem(
                                  value: jobLocation,
                                  child: Text(jobLocation),
                                ),
                              )
                              .toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              educationViewmodel.selectedDegree = newValue;
                              educationViewmodel.validateColorButton();
                            }
                          },
                          validator: (value) => value == null
                              ? context.localization.pleaseSelectYourDegree
                              : null,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: CustomTextFormField(
                          keyboardType: TextInputType.text,
                          hintText: context.localization.enterYourFieldOfStudy,
                          controller: educationViewmodel.fieldOfStudyController,
                          labelText: context.localization.fieldOfStudy,
                          validator: (val) => val == null || val.isEmpty
                              ? context.localization.pleaseEnterYourFieldOfStudy
                              : null,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  CustomTextFormField(
                    hintText: context.localization.enterYourInstitutionLocation,
                    controller: educationViewmodel.location,
                    labelText: context.localization.institutionLocation,
                    validator: (val) => val == null || val.isEmpty
                        ? context
                            .localization.pleaseEnterYourInstitutionLocation
                        : null,
                    keyboardType: TextInputType.text,
                  ),
                  verticalSpace(20),
                  DateInputField(
                    selectedDate: educationViewmodel.selectedDate,
                    onDateSelected: educationViewmodel.updateSelectedDate,
                    labelText: context.localization.graduationDate,
                  ),
                  verticalSpace(20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
