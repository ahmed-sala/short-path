import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/styles/colors/app_colore.dart';
import '../../../../../../core/styles/spacing.dart';
import '../../../../mangers/infromation_gathering/Project/Project_Viewmodel.dart';

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
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
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
