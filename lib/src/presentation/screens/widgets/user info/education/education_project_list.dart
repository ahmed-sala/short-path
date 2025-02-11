import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_viewmodel.dart';

import '../../../../../../core/styles/colors/app_colore.dart';
import '../../../../../../core/styles/spacing.dart';

class EducationProjectList extends StatelessWidget {
  const EducationProjectList({super.key, required this.viewModel});

  final EducationViewmodelNew viewModel;

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
            side: BorderSide(color: AppColors.primaryColor, width: 1),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.projectName!,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                verticalSpace(5),
                Text(
                  project.projectDescription!,
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
                if (project.toolsTechnologies!.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    children: project.toolsTechnologies!
                        .map((tool) => Chip(label: Text(tool)))
                        .toList(),
                  ),
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
                            content: Text('${project.projectName} removed!'),
                            backgroundColor: Colors.red,
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                scaffoldMessenger.hideCurrentSnackBar();
                                viewModel.addProjectBack(project);
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${project.projectName} restored!'),
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
