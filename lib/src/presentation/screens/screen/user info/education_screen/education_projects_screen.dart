import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/helpers/validations.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/education/education_header.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/education/education_project_list.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/education/tools_list.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/profile/suggestion_list.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';

class EducationProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<EducationViewmodelNew>();

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
                      )),
                      verticalSpace(30),
                      CustomTextFormField(
                        hintText: context.localization.enterProjectName,
                        keyboardType: TextInputType.text,
                        controller: viewModel.projectNameController,
                        labelText: context.localization.projectName,
                        validator: (value) {
                          return validateProjectName(value);
                        },
                      ),
                      verticalSpace(20),
                      CustomTextFormField(
                        hintText: context.localization.enterProjectDescription,
                        keyboardType: TextInputType.multiline,
                        controller: viewModel.projectDescriptionController,
                        labelText: context.localization.projectDescription,
                        validator: (value) {
                          return validateProjectDescription(value);
                        },
                      ),
                      verticalSpace(20),
                      CustomTextFormField(
                        hintText: context.localization.enterProjectLink,
                        keyboardType: TextInputType.url,
                        controller: viewModel.projectLinkController,
                        labelText: context.localization.projectLink,
                        validator: (value) {
                          return validateLink(value);
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
                              controller: viewModel.toolsTechnologiesController,
                              labelText:
                                  context.localization.toolsTechnologiesUsed,
                              validator: (value) => null,
                            ),
                          ),
                          SizedBox(
                            width: 50, // Adjust width as needed
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  viewModel.addToolsTechnologies(
                                    viewModel.toolsTechnologiesController.text,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (viewModel.filteredToolSuggestions.isNotEmpty &&
                          viewModel.toolsTechnologiesController.text.isNotEmpty)
                        SuggestionList(
                          suggestions: viewModel.filteredToolSuggestions,
                          onTap: viewModel.selectTool,
                        ),
                      verticalSpace(20),
                      if (viewModel.tollsTechnologies.isNotEmpty) ...[
                        ToolsListWidget(),
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
                      EducationProjectList(
                        viewModel: viewModel,
                      ),
                    ],
                  ),

                // NEXT Button
                CustomAuthButton(
                  text: context.localization.addNewEducation,
                  onPressed: viewModel.projects.isNotEmpty
                      ? () {
                          viewModel.addEducation();
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
    );
  }
}
