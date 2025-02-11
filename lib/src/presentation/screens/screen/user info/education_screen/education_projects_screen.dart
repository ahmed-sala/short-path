import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/education/tools_list.dart';

import '../../../../mangers/user_info/education/education_state.dart';
import '../../../../mangers/user_info/education/education_viewmodel.dart';
import '../../../../shared_widgets/custom_auth_button.dart';
import '../../../../shared_widgets/custom_auth_text_feild.dart';
import '../../../widgets/user info/education/education_header.dart';
import '../../../widgets/user info/education/education_project_list.dart';
import '../../../widgets/user info/profile/suggestion_list.dart';

class EducationProjectScreen extends StatelessWidget {
  const EducationProjectScreen({super.key});

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
                        title: 'Education Projects',
                      )),
                      verticalSpace(30),
                      CustomTextFormField(
                        hintText: 'Enter Project Name',
                        keyboardType: TextInputType.text,
                        controller: viewModel.projectNameController,
                        labelText: 'Project Name',
                        validator: viewModel.validateProjectName,
                      ),
                      verticalSpace(20),
                      CustomTextFormField(
                        hintText: 'Enter Project Description',
                        keyboardType: TextInputType.multiline,
                        controller: viewModel.projectDescriptionController,
                        labelText: 'Project Description',
                        validator: viewModel.validateProjectDescription,
                      ),
                      verticalSpace(20),
                      CustomTextFormField(
                        hintText: 'Enter Project Link',
                        keyboardType: TextInputType.url,
                        controller: viewModel.projectLinkController,
                        labelText: 'Project Link',
                        validator: viewModel.validateProjectLink,
                      ),
                      verticalSpace(20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 4,
                            child: CustomTextFormField(
                              hintText: 'Enter Tools/Technologies Used',
                              keyboardType: TextInputType.text,
                              controller: viewModel.toolsTechnologiesController,
                              labelText: 'Tools/Technologies Used',
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
                        text: 'Add Project',
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
                        'Added Projects:',
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
                  text: 'Add New Education',
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
