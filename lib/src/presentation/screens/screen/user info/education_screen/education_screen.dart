// education_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/education/education_header.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';

import '../../../../../../core/styles/spacing.dart';
import '../../../../mangers/user_info/education/education_state.dart';
import '../../../../mangers/user_info/education/education_viewmodel.dart';

class EducationScreen extends StatelessWidget {
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
                    title: 'Add Your Education',
                  )),
                  verticalSpace(30),
                  CustomTextFormField(
                    keyboardType: TextInputType.text,
                    hintText: 'Enter your institution name',
                    controller: educationViewmodel.institutionName,
                    labelText: 'Institution Name',
                    validator: (val) => val == null || val.isEmpty
                        ? 'Please enter your Institution name'
                        : null,
                  ),
                  verticalSpace(20),
                  CustomTextFormField(
                    keyboardType: TextInputType.text,
                    hintText: 'Enter your degree of certificate',
                    controller: educationViewmodel.degreeCertification,
                    labelText: 'Degree of Certification',
                    validator: (val) => val == null || val.isEmpty
                        ? 'Please enter your degree'
                        : null,
                  ),
                  verticalSpace(20),
                  CustomTextFormField(
                    hintText: 'Enter your institution location',
                    controller: educationViewmodel.location,
                    labelText: 'Institution Location',
                    validator: (val) => val == null || val.isEmpty
                        ? 'Please enter your Institution Location'
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
