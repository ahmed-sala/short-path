import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/dialogs/show_hide_loading.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/user_info/work_experience/work_experience_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/work_experience/work_experience_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../../../config/routes/routes_name.dart';
import '../../../../shared_widgets/custom_drop_downButton_form_field.dart';
import '../../../widgets/user info/profile/suggestion_list.dart';
import '../../../widgets/user info/work_exprience/detailed_list.dart';
import '../../../widgets/user info/work_exprience/tools_list.dart';

class WorkExperienceScreen extends StatelessWidget {
  WorkExperienceScreen({Key? key}) : super(key: key);
  WorkExperienceViewModel viewModel = getIt<WorkExperienceViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(title: const Text('Work Experience')),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: BlocConsumer<WorkExperienceViewModel, WorkExperienceState>(
              listener: (context, state) {
                if (state is WorkExperienceError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red),
                  );
                } else if (state is AddWorkExperienceSuccess) {
                  navKey.currentState!
                      .pushReplacementNamed(RoutesName.education);
                } else if (state is AddWorkExperienceFailed) {
                  showAwesomeDialog(context,
                      title: 'Error',
                      desc: state.message,
                      onOk: () {},
                      dialogType: DialogType.error);
                } else if (state is AddWorkExperienceLoading) {
                  showLoading(context, 'Adding Work Experience...');
                } else if (state is SessionExpired) {
                  showAwesomeDialog(context,
                      title: 'Session Expired',
                      desc: 'Your session has expired. Please login again.',
                      onOk: () {
                    navKey.currentState!.pushReplacementNamed(RoutesName.login);
                  }, dialogType: DialogType.error);
                }
              },
              builder: (context, state) {
                final viewModel = context.read<WorkExperienceViewModel>();
                final dateError = viewModel.validateDates();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            controller: viewModel.jobTitleController,
                            labelText: 'Job Title',
                            hintText: 'Enter Job Title',
                            validator: viewModel.validateJobTitle,
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(20),

                          CustomTextFormField(
                            controller: viewModel.companyNameController,
                            labelText: 'Company Name',
                            hintText: 'Enter Company Name',
                            validator: viewModel.validateCompanyName,
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(20),

                          CustomTextFormField(
                            controller: viewModel.companyFieldController,
                            labelText: 'Company Field',
                            hintText: 'Enter Company Field',
                            validator: viewModel.validateCompanyField,
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(20),

                          CustomDropdownButtonFormField(
                            labelText: 'Job Type',
                            hintText: 'Select Job Type',
                            value: viewModel.selectedJobType,
                            items: viewModel.jobTypes
                                .map(
                                  (jobType) => DropdownMenuItem(
                                    value: jobType,
                                    child: Text(jobType),
                                  ),
                                )
                                .toList(),
                            onChanged: viewModel.selectJobType,
                            validator: viewModel.validateJobType,
                          ),
                          verticalSpace(20),

                          CustomDropdownButtonFormField(
                            labelText: 'Job Location',
                            hintText: 'Select Job Location',
                            value: viewModel.selectedJobLocation,
                            items: viewModel.jobLocations
                                .map(
                                  (jobLocation) => DropdownMenuItem(
                                    value: jobLocation,
                                    child: Text(jobLocation),
                                  ),
                                )
                                .toList(),
                            onChanged: viewModel.selectJobLocation,
                            validator: viewModel.validateJobLocation,
                          ),
                          verticalSpace(20),

                          // Start Date Picker
                          GestureDetector(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2030),
                              );
                              if (pickedDate != null)
                                viewModel.selectStartDate(pickedDate);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 70.h,
                              padding: EdgeInsets.only(top: 20.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F4F4),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Start Date',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  viewModel.startDate != null
                                      ? DateFormat('M/d/yyyy')
                                          .format(viewModel.startDate!)
                                      : 'Select Date',
                                  style: TextStyle(
                                    color: viewModel.startDate == null
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (dateError != null && viewModel.startDate == null)
                            Padding(
                              padding: EdgeInsets.only(left: 12.w, top: 4.h),
                              child: Text(
                                dateError,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12.sp),
                              ),
                            ),
                          verticalSpace(20),

                          // End Date Picker
                          GestureDetector(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2030),
                              );
                              if (pickedDate != null)
                                viewModel.selectEndDate(pickedDate);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 70.h,
                              padding: EdgeInsets.only(top: 20.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F4F4),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'End Date',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  viewModel.endDate != null
                                      ? DateFormat('M/d/yyyy')
                                          .format(viewModel.endDate!)
                                      : 'Select Date',
                                  style: TextStyle(
                                    color: viewModel.endDate == null
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (dateError != null && viewModel.endDate == null)
                            Padding(
                              padding: EdgeInsets.only(left: 12.w, top: 4.h),
                              child: Text(
                                dateError,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12.sp),
                              ),
                            ),
                          verticalSpace(20),

                          CustomTextFormField(
                            controller: viewModel.summaryController,
                            labelText: 'Job Summary',
                            hintText: 'Enter Job Summary',
                            validator: viewModel.validateSummary,
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(20),

                          // Tool/Technology
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  controller: viewModel.toolController,
                                  labelText: 'Tool/Technology',
                                  hintText: 'Enter Tool/Technology',
                                  validator: (value) =>
                                      viewModel.toolsTechnologiesUsed.isEmpty
                                          ? 'Add at least one tool'
                                          : null,
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add,
                                    color: AppColors.primaryColor),
                                onPressed: () {
                                  viewModel
                                      .addTool(viewModel.toolController.text);
                                },
                              ),
                            ],
                          ),
                          if (viewModel.filteredToolSuggestions.isNotEmpty &&
                              viewModel.toolController.text.isNotEmpty)
                            SuggestionList(
                              suggestions: viewModel.filteredToolSuggestions,
                              onTap: viewModel.selectTool,
                            ),
                          if (viewModel.toolsTechnologiesUsed.isNotEmpty)
                            const ToolsList(),

                          verticalSpace(20),

                          CustomAuthButton(
                            text: 'Add Work Experience',
                            onPressed: viewModel.addWorkExperience,
                            color: AppColors.primaryColor,
                          ),
                          verticalSpace(30),
                        ],
                      ),
                    ),

                    // Added Experiences List
                    if (viewModel.workExperiences.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Added Work Experiences:',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          verticalSpace(10),
                          DetailedList(
                            viewModel: viewModel,
                          ),
                        ],
                      ),

                    // NEXT Button
                    CustomAuthButton(
                      text: 'NEXT',
                      onPressed: viewModel.workExperiences.isNotEmpty
                          ? () {
                              viewModel.next();
                            }
                          : null,
                      color: viewModel.workExperiences.isNotEmpty
                          ? AppColors.primaryColor
                          : Color(0xFF5C6673),
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
