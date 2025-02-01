// education_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/education/education_header.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';

import '../../../../../../core/styles/colors/app_colore.dart';
import '../../../../../../core/styles/spacing.dart';
import '../../../../../../dependency_injection/di.dart';
import '../../../../mangers/user_info/education/education_state.dart';
import '../../../../mangers/user_info/education/education_viewmodel.dart';

class EducationScreen extends StatelessWidget {
  EducationViewmodel educationViewmodel = getIt<EducationViewmodel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Text('Education Details'),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => educationViewmodel,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
            child: BlocConsumer<EducationViewmodel, EducationState>(
              listener: (context, state) {
                // Handle any side effects here
              },
              builder: (context, state) {
                return Form(
                  key: educationViewmodel.formKey,
                  onChanged: educationViewmodel.validateColorButton,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EducationHeader(),
                      verticalSpace(30),
                      CustomTextFormField(
                        keyboardType: TextInputType.text,
                        hintText: 'Enter your University/School name',
                        controller: educationViewmodel.schoolController,
                        labelText: 'University/School',
                        validator: (val) => val == null || val.isEmpty
                            ? 'Please enter your university/school name'
                            : null,
                      ),
                      verticalSpace(20),
                      CustomTextFormField(
                        keyboardType: TextInputType.text,
                        hintText: 'Enter your degree',
                        controller: educationViewmodel.degreeController,
                        labelText: 'Degree',
                        validator: (val) => val == null || val.isEmpty
                            ? 'Please enter your degree'
                            : null,
                      ),
                      verticalSpace(20),
                      CustomTextFormField(
                        hintText: 'Enter your field of study',
                        controller: educationViewmodel.fieldOfStudyController,
                        labelText: 'Field of Study',
                        validator: (val) => val == null || val.isEmpty
                            ? 'Please enter your field of study'
                            : null,
                        keyboardType: TextInputType.text,
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
                            educationViewmodel.updateSelectedDate(pickedDate);
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
                              labelText: 'Graduation Date',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              educationViewmodel.selectedDate != null
                                  ? DateFormat('M/d/yyyy')
                                      .format(educationViewmodel.selectedDate!)
                                  : 'Select Date',
                              style: TextStyle(
                                color: educationViewmodel.selectedDate == null
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(20),
                      CustomAuthButton(
                        text: 'NEXT',
                        onPressed: educationViewmodel.validate
                            ? educationViewmodel.nextButton
                            : null,
                        color: educationViewmodel.validate
                            ? AppColors.primaryColor
                            : const Color(0xFF5C6673),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
