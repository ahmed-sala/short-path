import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import '../../../../../short_path.dart';
import '../../../../mangers/infromation_gathering/Project/Project_State.dart';
import '../../../../mangers/infromation_gathering/Project/Project_Viewmodel.dart';
import '../../../../shared_widgets/custom_auth_button.dart';
import '../../../../shared_widgets/custom_auth_text_feild.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProjectViewmodel viewModel = getIt.get<ProjectViewmodel>();
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Projects'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: BlocConsumer<ProjectViewmodel, ProjectState>(
              listener: (context, state) {
                if (state is ProjectUpdated) {
                }
              },
              buildWhen: (previous, current) =>
              current is ProjectInitialState ||
                  current is ValidateColorButtonState ||
                  current is ProjectUpdated,
              builder: (context, state) {
                final viewModel = context.read<ProjectViewmodel>();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Form for Adding Project
                    Form(
                      key: viewModel.formKey,
                      onChanged: viewModel.validateColorButton,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            hintText: 'Enter Project Title',
                            keyboardType: TextInputType.text,
                            controller: viewModel.projectTitleController,
                            labelText: 'Project Title',
                            validator: viewModel.validateProjectTitle,
                          ),
                          verticalSpace(20),

                          // Role Field with Dropdown Suggestions
                          DropdownButtonFormField<String>(
                            value: viewModel.roleController.text.isEmpty ? null : viewModel.roleController.text,
                            hint: const Text('Select Role'),
                            items: ['Full-time', 'Part-time', 'Freelance'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                viewModel.roleController.text = newValue;
                                viewModel.validateColorButton();
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Role',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: viewModel.validateRole,
                          ),
                          verticalSpace(20),

                          CustomTextFormField(
                            hintText: 'Enter Description',
                            keyboardType: TextInputType.multiline,
                            controller: viewModel.descriptionController,
                            labelText: 'Description',
                            validator: viewModel.validateDescription,
                          ),
                          verticalSpace(20),
                          CustomTextFormField(
                            hintText: 'Enter Technologies Used',
                            keyboardType: TextInputType.text,
                            controller: viewModel.technologiesUsedController,
                            labelText: 'Technologies Used',
                            validator: viewModel.validateTechnologiesUsed,
                          ),
                          verticalSpace(20),
                          CustomAuthButton(
                            text: 'Add Project',
                            onPressed: viewModel.addProject,
                            color: AppColors.primaryColor,
                          ),
                          verticalSpace(30),
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
                                  side: BorderSide(color: AppColors.primaryColor, width: 1),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        project.projectTitle,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      verticalSpace(5),
                                      Text(
                                        'Role: ${project.role}',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                      verticalSpace(5),
                                      Text(
                                        'Description: ${project.description}',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                      verticalSpace(5),
                                      Text(
                                        'Technologies Used: ${project.technologiesUsed}',
                                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                                      ),
                                      verticalSpace(10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
                                              if (scaffoldMessenger == null) {
                                                debugPrint('ScaffoldMessenger not found.');
                                                return;
                                              }

                                              scaffoldMessenger.hideCurrentSnackBar();
                                              viewModel.removeProject(project);

                                              scaffoldMessenger.showSnackBar(
                                                SnackBar(
                                                  content: Text('${project.projectTitle} removed!'),
                                                  backgroundColor: Colors.red,
                                                  action: SnackBarAction(
                                                    label: 'Undo',
                                                    onPressed: () {
                                                      scaffoldMessenger.hideCurrentSnackBar();
                                                      viewModel.addProjectBack(project);
                                                      scaffoldMessenger.showSnackBar(
                                                        SnackBar(
                                                          content: Text('${project.projectTitle} restored!'),
                                                          backgroundColor: Colors.green,
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
                      text: 'NEXT',
                      onPressed: viewModel.projects.isNotEmpty
                          ? () {
                        navKey.currentState!.pushReplacementNamed(RoutesName.certification);
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