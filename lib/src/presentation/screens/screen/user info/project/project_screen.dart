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
import 'package:short_path/src/presentation/mangers/user_info/Project/Project_State.dart';
import 'package:short_path/src/presentation/mangers/user_info/Project/Project_Viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/project/project_list.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/project/tool_list.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_drop_downButton_form_field.dart';

import '../../../../../short_path.dart';
import '../../../../shared_widgets/progress_bar.dart';
import '../../../../shared_widgets/suggetion_list.dart';
import '../../../widgets/user info/profile/header_widget.dart';

class ProjectScreen extends StatelessWidget {
  ProjectScreen({super.key});

  ProjectViewmodel viewModel = getIt<ProjectViewmodel>();

  /// Defines a map from localized role names to raw values.
  Map<String, String> getRoleDisplayMap(BuildContext context) => {
        context.localization.fullTime: 'Full Time',
        context.localization.partTime: 'Part Time',
        context.localization.freelance: 'Freelance',
      };

  List<String> getDisplayRole(BuildContext context) =>
      getRoleDisplayMap(context).keys.toList();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: BlocConsumer<ProjectViewmodel, ProjectState>(
              listener: (context, state) {
                if (state is AddProjectFailure) {
                  showAwesomeDialog(context,
                      title: context.localization.error,
                      desc: state.error,
                      onOk: () {},
                      dialogType: DialogType.error);
                } else if (state is AddProjectSuccess) {
                  navKey.currentState!.pushNamedAndRemoveUntil(
                      RoutesName.certification, (route) => false);
                } else if (state is AddProjectLoading) {
                  showLoading(context, context.localization.addingProjects);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(50),
                    const Center(child: HeaderWidget()),
                    StepProgressBar(
                      currentStep: 5,
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
                            hintText: context.localization.enterProjectTitle,
                            keyboardType: TextInputType.text,
                            controller: viewModel.projectTitleController,
                            labelText: context.localization.projectTitle,
                            validator: (value) {
                              return validateProjectName(value);
                            },
                          ),
                          verticalSpace(20),
                          CustomDropdownButtonFormField(
                            labelText: context.localization.role,
                            hintText: context.localization.selectRole,
// Map raw value in roleController.text to localized string for display
                            value: viewModel.roleController.text.isNotEmpty
                                ? getRoleDisplayMap(context)
                                    .entries
                                    .firstWhere(
                                      (entry) =>
                                          entry.value ==
                                          viewModel.roleController.text,
                                      orElse: () => const MapEntry('', ''),
                                    )
                                    .key
                                : null,
                            // Populate dropdown with localized role names
                            items: getDisplayRole(context)
                                .map((displayRole) => DropdownMenuItem(
                                      value: displayRole,
                                      child: Text(displayRole),
                                    ))
                                .toList(),
                            // On selection, store the raw value in roleController
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                final rawValue =
                                    getRoleDisplayMap(context)[newValue];
                                print(
                                    'Selected role: $newValue, Raw value: $rawValue');
                                if (rawValue != null) {
                                  viewModel.roleController.text = rawValue;
                                }
                              }
                            },
                            validator: (value) {
                              return validateRole(value);
                            },
                          ),
                          verticalSpace(20),
                          CustomTextFormField(
                            hintText: context.localization.enterProjectLink,
                            keyboardType: TextInputType.text,
                            controller: viewModel.projectLinkController,
                            labelText: context.localization.projectLink,
                            validator: (value) {
                              return validateLink(value);
                            },
                          ),
                          verticalSpace(20),
                          CustomTextFormField(
                            hintText:
                                context.localization.enterProjectDescription,
                            keyboardType: TextInputType.multiline,
                            controller: viewModel.descriptionController,
                            labelText: context.localization.projectDescription,
                            validator: (value) {
                              return validateProjectDescription(value);
                            },
                          ),
                          verticalSpace(20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 4,
                                child: CustomTextFormField(
                                  hintText: context
                                      .localization.enterToolsTechnologiesUsed,
                                  keyboardType: TextInputType.text,
                                  controller:
                                      viewModel.technologiesUsedController,
                                  labelText: context
                                      .localization.toolsTechnologiesUsed,
                                  // No validation required here
                                  validator: (value) => null,
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      viewModel.addToolsTechnologies(
                                        viewModel
                                            .technologiesUsedController.text
                                            .trim(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (viewModel.filteredToolSuggestions.isNotEmpty &&
                              viewModel
                                  .technologiesUsedController.text.isNotEmpty)
                            SuggestionList(
                              suggestions: viewModel.filteredToolSuggestions,
                              onTap: viewModel
                                  .selectTool, // fills the field, adds it, and clears
                            ),
                          verticalSpace(20),
                          if (viewModel.toolsTechnologies.isNotEmpty) ...[
                            const ToolList(),
                            verticalSpace(20),
                          ],
                          verticalSpace(20),
                          CustomAuthButton(
                            text: context.localization.addProject,
                            onPressed: viewModel.addProject,
                            color: AppColors.primaryColor,
                          ),
                          verticalSpace(30),
                        ],
                      ),
                    ),
                    if (viewModel.projects.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.localization.addedProjects,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          verticalSpace(10),
                          ProjectList(
                            viewModel: viewModel,
                          ),
                        ],
                      ),
                    CustomAuthButton(
                      text: context.localization.next,
                      onPressed: viewModel.projects.isNotEmpty
                          ? () {
                              context.read<ProjectViewmodel>().next();
                            }
                          : null,
                      color: viewModel.projects.isNotEmpty
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
