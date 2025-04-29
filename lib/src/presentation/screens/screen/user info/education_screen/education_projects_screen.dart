import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/helpers/validations.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/src/data/static_data/demo_data_list.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/education/education_header.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/education/education_project_list.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/education/tools_list.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';

import '../../../../shared_widgets/suggetion_list.dart';
import '../../../../shared_widgets/toast_dialoge.dart';

class EducationProjectScreen extends StatelessWidget {
  const EducationProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<EducationViewmodelNew>();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
        child: BlocBuilder<EducationViewmodelNew, EducationState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Form for Adding Project
                Form(
                  key: viewModel.educationProjectFormKey,
                  onChanged: viewModel.validateColorButton,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: EducationHeader(
                          title: context.localization.educationProjects,
                        ),
                      ),
                      verticalSpace(30),
                      CustomTextFormField(
                        hintText: context.localization.enterProjectName,
                        keyboardType: TextInputType.text,
                        controller: viewModel.projectNameController,
                        labelText: context.localization.projectName,
                        validator: validateProjectName,
                      ),
                      verticalSpace(20),
                      CustomTextFormField(
                        hintText: context.localization.enterProjectDescription,
                        keyboardType: TextInputType.multiline,
                        controller: viewModel.projectDescriptionController,
                        labelText: context.localization.projectDescription,
                        validator: validateProjectDescription,
                      ),
                      verticalSpace(20),
                      CustomTextFormField(
                        hintText: context.localization.enterProjectLink,
                        keyboardType: TextInputType.url,
                        controller: viewModel.projectLinkController,
                        labelText: context.localization.projectLink,
                        validator: validateLink,
                      ),
                      verticalSpace(20),

                      // Tools / Technologies with autocomplete
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 4,
                            child: CustomTextFormField(
                              hintText: context
                                  .localization.enterToolsTechnologiesUsed,
                              keyboardType: TextInputType.text,
                              controller: viewModel.toolsTechnologiesController,
                              labelText:
                                  context.localization.toolsTechnologiesUsed,
                              validator: (_) => null,
                              onChanged: (value) {
                                final input = value.toLowerCase();
                                viewModel.filteredToolSuggestions =
                                    technicalSkills.where((tool) {
                                  final lower = tool.toLowerCase();
                                  return lower.contains(input) &&
                                      !viewModel.tollsTechnologies
                                          .map((t) => t.toLowerCase())
                                          .contains(lower);
                                }).toList();
                              },
                            ),
                          ),
                          SizedBox(width: 50),
                          Center(
                            child: IconButton(
                              icon: const Icon(Icons.add,
                                  color: AppColors.primaryColor),
                              onPressed: () {
                                final raw = viewModel
                                    .toolsTechnologiesController.text
                                    .trim();
                                final lower = raw.toLowerCase();

                                // must be in static list
                                if (!technicalSkills
                                    .map((s) => s.toLowerCase())
                                    .contains(lower)) {
                                  ToastDialog.show(
                                    'Please choose a tool from suggestions',
                                    Colors.red,
                                  );
                                  return;
                                }
                                // prevent duplicates
                                if (viewModel.tollsTechnologies
                                    .map((t) => t.toLowerCase())
                                    .contains(lower)) {
                                  ToastDialog.show(
                                    'Tool "$raw" already added',
                                    Colors.orange,
                                  );
                                  return;
                                }
                                // add + clear
                                viewModel.addToolsTechnologies(raw);
                                viewModel.toolsTechnologiesController.clear();
                                // remove from master to avoid re-suggest
                                technicalSkills.removeWhere(
                                    (s) => s.toLowerCase() == lower);
                                viewModel.filteredToolSuggestions = [];
                              },
                            ),
                          ),
                        ],
                      ),

                      // SuggestionList dropdown
                      if (viewModel.filteredToolSuggestions.isNotEmpty &&
                          viewModel.toolsTechnologiesController.text.isNotEmpty)
                        SuggestionList(
                          suggestions: viewModel.filteredToolSuggestions,
                          onTap: (selection) {
                            viewModel.toolsTechnologiesController.text =
                                selection;
                            // mimic add button tap
                            viewModel.addToolsTechnologies(selection);
                            technicalSkills.remove(selection);
                            viewModel.filteredToolSuggestions = [];
                          },
                        ),

                      verticalSpace(20),
                      if (viewModel.tollsTechnologies.isNotEmpty) ...[
                        const ToolsListWidget(),
                        verticalSpace(20),
                      ],

                      CustomAuthButton(
                        text: context.localization.addProject,
                        onPressed: viewModel.addProject,
                        color: AppColors.primaryColor,
                      ),
                      verticalSpace(40),
                    ],
                  ),
                ),

                // Display the List of Projects
                if (viewModel.projects.isNotEmpty) ...[
                  Text(
                    context.localization.addedProjects,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpace(10),
                  EducationProjectList(viewModel: viewModel),
                ],

                // NEXT Button
                CustomAuthButton(
                  text: context.localization.addNewEducation,
                  onPressed: viewModel.projects.isNotEmpty
                      ? viewModel.addEducation
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
    );
  }
}
