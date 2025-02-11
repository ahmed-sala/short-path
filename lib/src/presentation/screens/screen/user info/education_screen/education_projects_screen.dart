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

class EducationProjectScreen extends StatelessWidget {
  final List<String> suggestedTechnologies = [
    'Flutter',
    'Dart',
    'React',
    'Angular',
    'Vue.js',
    'Node.js',
    'Python',
    'Java',
    'C#',
    'JavaScript',
    'TypeScript',
    'Swift',
    'Kotlin',
    'Go',
    'Ruby',
    'PHP',
    'SQL',
    'MongoDB',
    'Firebase',
    'AWS',
    'Docker',
    'Kubernetes',
    'Git',
    'Jenkins',
    'CI/CD',
  ];

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
                            child: Autocomplete<String>(
                              optionsBuilder: (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.isEmpty) {
                                  return const Iterable<String>.empty();
                                }
                                return suggestedTechnologies.where((String option) {
                                  return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                });
                              },
                              onSelected: (String selection) {
                                viewModel.toolsTechnologiesController.text = selection;
                                viewModel.addToolsTechnologies(selection);
                              },
                              fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                                return TextFormField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Tools/Technologies Used',
                                    labelText: 'Tools/Technologies Used',
                                  ),
                                  onChanged: (value) {
                                    viewModel.toolsTechnologiesController.text = value;
                                  },
                                );
                              },
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.projects.length,
                        itemBuilder: (context, index) {
                          final project = viewModel.projects[index];

                          return Card(
                            margin: EdgeInsets.only(bottom: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: AppColors.primaryColor, width: 1),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Project Name: ${project.projectName}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  verticalSpace(5),
                                  Text(
                                      'Project Description: ${project.projectDescription}',
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  verticalSpace(5),
                                  Text(
                                    'Link: ${project.projectLink}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  verticalSpace(5),
                                  // Display Tools/Technologies Used
                                  if (project.toolsTechnologies != null && project.toolsTechnologies!.isNotEmpty) ...[
                                    Text(
                                      'Tools/Technologies: ${project.toolsTechnologies!.join(', ')}',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    verticalSpace(5),
                                  ],
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          final scaffoldMessenger =
                                          ScaffoldMessenger.maybeOf(
                                              context);
                                          if (scaffoldMessenger == null) {
                                            debugPrint(
                                                'ScaffoldMessenger not found.');
                                            return;
                                          }

                                          scaffoldMessenger
                                              .hideCurrentSnackBar();
                                          viewModel.removeProject(project);

                                          scaffoldMessenger.showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  '${project.projectName} removed!'),
                                              backgroundColor: Colors.red,
                                              action: SnackBarAction(
                                                label: 'Undo',
                                                onPressed: () {
                                                  scaffoldMessenger
                                                      .hideCurrentSnackBar();
                                                  viewModel
                                                      .addProjectBack(project);
                                                  scaffoldMessenger
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          '${project.projectName} restored!'),
                                                      backgroundColor:
                                                      Colors.green,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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