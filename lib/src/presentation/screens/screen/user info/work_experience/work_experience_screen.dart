import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/helpers/validations.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/dialogs/show_hide_loading.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/user_info/work_experience/work_experience_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/work_experience/work_experience_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../../../config/routes/routes_name.dart';
import '../../../../../data/static_data/demo_data_list.dart';
import '../../../../shared_widgets/custom_drop_downButton_form_field.dart';
import '../../../../shared_widgets/date_input_feild.dart';
import '../../../../shared_widgets/progress_bar.dart';
import '../../../../shared_widgets/suggetion_list.dart';
import '../../../../shared_widgets/toast_dialoge.dart';
import '../../../widgets/user info/profile/header_widget.dart';
import '../../../widgets/user info/work_exprience/detailed_list.dart';
import '../../../widgets/user info/work_exprience/tools_list.dart';

class WorkExperienceScreen extends StatelessWidget {
  WorkExperienceScreen({Key? key}) : super(key: key);
  WorkExperienceViewModel viewModel = getIt<WorkExperienceViewModel>();

  Map<String, String> getJobTypeDisplayMap(BuildContext context) => {
        context.localization.fullTime: 'Full_Time',
        context.localization.partTime: 'Part_Time',
        context.localization.contract: 'Contract',
        context.localization.internship: 'Internship',
      };

  Map<String, String> getJobLocationDisplayMap(BuildContext context) => {
        context.localization.remote: 'Remote',
        context.localization.onsite: 'Onsite',
        context.localization.hybrid: 'Hybrid',
      };

  List<String> getDisplayJobTypes(BuildContext context) =>
      getJobTypeDisplayMap(context).keys.toList();

  List<String> getDisplayJobLocations(BuildContext context) =>
      getJobLocationDisplayMap(context).keys.toList();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
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
                      title: context.localization.error,
                      desc: state.message,
                      onOk: () {},
                      dialogType: DialogType.error);
                } else if (state is AddWorkExperienceLoading) {
                  showLoading(
                      context, context.localization.addingWorkExperience);
                } else if (state is SessionExpired) {
                  showAwesomeDialog(context,
                      title: context.localization.sessionExpired,
                      desc: context.localization
                          .yourSessionHasExpiredPleaseLoginAgain, onOk: () {
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
                    verticalSpace(50),
                    const Center(child: HeaderWidget()),
                    StepProgressBar(
                      currentStep: 4,
                      stepNames: [
                        context.localization.personalInfo,
                        context.localization.skills,
                        context.localization.education,
                        context.localization.experience,
                        context.localization.projects,
                        context.localization.certifications,
                        context.localization.additionalInfo,
                      ],
                    ),
                    verticalSpace(22),
                    Form(
                      key: viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            controller: viewModel.jobTitleController,
                            labelText: context.localization.jobTitle,
                            hintText: context.localization.enterJobTitle,
                            validator: (value) {
                              return validateJobTitle(value);
                            },
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(20),

                          CustomTextFormField(
                            controller: viewModel.companyNameController,
                            labelText: context.localization.companyName,
                            hintText: context.localization.enterCompanyName,
                            validator: (value) {
                              return validateCompanyName(value);
                            },
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(20),

                          CustomTextFormField(
                            controller: viewModel.companyFieldController,
                            labelText: context.localization.companyField,
                            hintText: context.localization.enterCompanyField,
                            validator: (value) {
                              return validateCompanyField(value);
                            },
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(20),

                          CustomDropdownButtonFormField(
                            labelText: context.localization.jobType,
                            hintText: context.localization.selectJobType,
                            value: viewModel.selectedJobType != null
                                ? getJobTypeDisplayMap(context)
                                    .entries
                                    .firstWhere(
                                      (entry) =>
                                          entry.value ==
                                          viewModel.selectedJobType,
                                      orElse: () => const MapEntry('', ''),
                                    )
                                    .key
                                : null,
                            items: getDisplayJobTypes(context)
                                .map((displayType) => DropdownMenuItem(
                                      value: displayType,
                                      child: Text(displayType),
                                    ))
                                .toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                final rawValue =
                                    getJobTypeDisplayMap(context)[newValue];
                                print(
                                    "Selected Job Type: $newValue, Raw Value: $rawValue");
                                if (rawValue != null) {
                                  viewModel.selectJobType(rawValue);
                                }
                              }
                            },
                            validator: (value) {
                              return validateJobType(value);
                            },
                          ),
                          verticalSpace(20),

                          CustomDropdownButtonFormField(
                            labelText: context.localization.jobLocation,
                            hintText: context.localization.selectJobLocation,
                            value: viewModel.selectedJobLocation != null
                                ? getJobLocationDisplayMap(context)
                                    .entries
                                    .firstWhere(
                                      (entry) =>
                                          entry.value ==
                                          viewModel.selectedJobLocation,
                                      orElse: () => const MapEntry('', ''),
                                    )
                                    .key
                                : null,
                            items: getDisplayJobLocations(context)
                                .map((displayLocation) => DropdownMenuItem(
                                      value: displayLocation,
                                      child: Text(displayLocation),
                                    ))
                                .toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                final rawValue =
                                    getJobLocationDisplayMap(context)[newValue];
                                print(
                                    "Selected Job Location: $newValue, Raw Value: $rawValue");
                                if (rawValue != null) {
                                  viewModel.selectJobLocation(rawValue);
                                }
                              }
                            },
                            validator: (value) {
                              return validateJobLocation(value);
                            },
                          ),
                          verticalSpace(20),

                          // Start Date Picker
                          DateInputField(
                            selectedDate: viewModel.startDate,
                            onDateSelected: viewModel.selectStartDate,
                            labelText: context.localization.startDate,
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
                              Text(context.localization.currentlyWorkingHere),
                            ],
                          ),

                          verticalSpace(20),

                          // Conditionally show End Date Picker
                          if (!viewModel.isCurrentlyWorking) ...[
                            DateInputField(
                              selectedDate: viewModel.endDate,
                              onDateSelected: viewModel.selectEndDate,
                              labelText: context.localization.endDate,
                            ),
                            verticalSpace(20),
                          ],

                          CustomTextFormField(
                            controller: viewModel.summaryController,
                            labelText: context.localization.jobSummary,
                            hintText: context.localization.enterJobSummary,
                            validator: (value) {
                              return validateSummary(value);
                            },
                            keyboardType: TextInputType.text,
                          ),
                          verticalSpace(20),

                          // Tool/Technology
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 4,
                                child: CustomTextFormField(
                                  hintText: context
                                      .localization.enterToolsTechnologiesUsed,
                                  keyboardType: TextInputType.text,
                                  controller: viewModel.toolController,
                                  labelText: context
                                      .localization.toolsTechnologiesUsed,
                                  validator: (value) => null,
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(Icons.add,
                                        color: AppColors.primaryColor),
                                    onPressed: () {
                                      final raw =
                                          viewModel.toolController.text.trim();
                                      final lower = raw.toLowerCase();

                                      // must be in static list
                                      if (!technicalSkills
                                          .map((s) => s.toLowerCase())
                                          .contains(lower)) {
                                        ToastDialog.show(
                                          context.localization
                                              .pleaseChooseAToolFromSuggestions,
                                          Colors.red,
                                        );
                                        return;
                                      }
                                      // prevent duplicates
                                      if (viewModel.tollsTechnologies
                                          .map((t) => t.toLowerCase())
                                          .contains(lower)) {
                                        ToastDialog.show(
                                          context.localization
                                              .toolAlreadyAdded(raw),
                                          Colors.orange,
                                        );
                                        return;
                                      }
                                      // add + clear
                                      viewModel.addToolsTechnologies(raw);
                                      viewModel.toolController.clear();
                                      // remove from master to avoid re-suggest
                                      technicalSkills.removeWhere(
                                          (s) => s.toLowerCase() == lower);
                                      viewModel.filteredToolSuggestions = [];
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (viewModel.filteredToolSuggestions.isNotEmpty &&
                              viewModel.toolController.text.isNotEmpty)
                            SuggestionList(
                              suggestions: viewModel.filteredToolSuggestions,
                              onTap: viewModel
                                  .selectTool, // fills the field, adds it, and clears
                            ),
                          if (viewModel.tollsTechnologies.isNotEmpty)
                            const ToolsList(),

                          verticalSpace(20),

                          CustomAuthButton(
                            text: context.localization.addWorkExperience,
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
                            context.localization.addedWorkExperience,
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
                      text: context.localization.next,
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
