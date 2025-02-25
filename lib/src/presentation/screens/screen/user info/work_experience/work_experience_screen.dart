import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/helpers/validations.dart';
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
import '../../../../shared_widgets/date_input_feild.dart';
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
                  navKey.currentState!.pushNamedAndRemoveUntil(
                      RoutesName.project, (route) => false);
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
                    navKey.currentState!.pushNamedAndRemoveUntil(
                        RoutesName.login, (route) => false);
                  }, dialogType: DialogType.error);
                }
              },
              builder: (context, state) {
                final viewModel = context.read<WorkExperienceViewModel>();

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
                            validator: (value) {
                              return validateJobTitle(value);
                            },
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(20),

                          CustomTextFormField(
                            controller: viewModel.companyNameController,
                            labelText: 'Company Name',
                            hintText: 'Enter Company Name',
                            validator: (value) {
                              return validateCompanyName(value);
                            },
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(20),

                          CustomTextFormField(
                            controller: viewModel.companyFieldController,
                            labelText: 'Company Field',
                            hintText: 'Enter Company Field',
                            validator: (value) {
                              return validateCompanyField(value);
                            },
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
                            validator: (value) {
                              return validateJobType(value);
                            },
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
                            validator: (value) {
                              return validateJobLocation(value);
                            },
                          ),
                          verticalSpace(20),

                          // Start Date Picker
                          DateInputField(
                            selectedDate: viewModel.startDate,
                            onDateSelected: viewModel.selectStartDate,
                            labelText: 'Start Date',
                          ),

// Checkbox: Currently Working Here
                          Row(
                            children: [
                              Checkbox(
                                value: viewModel.isCurrentlyWorking,
                                checkColor: Colors.white,
                                fillColor: MaterialStateProperty.resolveWith(
                                    (states) => AppColors.primaryColor),
                                onChanged: (value) {
                                  viewModel.setCurrentlyWorking(value!);
                                },
                              ),
                              const Text("Currently working here"),
                            ],
                          ),

                          verticalSpace(20),

// Conditionally show End Date Picker
                          if (!viewModel.isCurrentlyWorking) ...[
                            DateInputField(
                              selectedDate: viewModel.endDate,
                              onDateSelected: viewModel.selectEndDate,
                              labelText: 'End Date',
                            ),
                            verticalSpace(20),
                          ],

                          CustomTextFormField(
                            controller: viewModel.summaryController,
                            labelText: 'Job Summary',
                            hintText: 'Enter Job Summary',
                            validator: (value) {
                              return validateSummary(value);
                            },
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
