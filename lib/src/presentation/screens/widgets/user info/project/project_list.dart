import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/src/presentation/mangers/user_info/Project/Project_Viewmodel.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({super.key, required this.viewModel});

  final ProjectViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.projects.length,
      itemBuilder: (context, index) {
        final project = viewModel.projects[index];

        return Card(
          margin: EdgeInsets.only(bottom: 10.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: AppColors.primaryColor, width: 1),
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
                  project.role,
                  style: TextStyle(fontSize: 14.sp),
                ),
                verticalSpace(5),
                Text(
                  project.description,
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
                if (project.technologiesUsed.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    children: project.technologiesUsed
                        .split(',') // Split the string into a list of tools
                        .map((tool) => Chip(
                            label: Text(tool.trim()))) // Trim any extra spaces
                        .toList(),
                  ),
                verticalSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        final scaffoldMessenger =
                            ScaffoldMessenger.maybeOf(context);
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
                                    content: Text(
                                        '${project.projectTitle} restored!'),
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
    );
  }
}
