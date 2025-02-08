import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/styles/colors/app_colore.dart';
import '../../../../../../core/styles/spacing.dart';
import '../../../../mangers/user_info/work_experience/work_experience_viewmodel.dart';

class DetailedList extends StatelessWidget {
  const DetailedList({super.key, required this.viewModel});
  final WorkExperienceViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: viewModel.workExperiences.length,
      itemBuilder: (context, index) {
        final exp = viewModel.workExperiences[index];
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
                  exp.jobTitle,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                verticalSpace(5),
                Text('Company: ${exp.companyName}'),
                verticalSpace(5),
                Text('Field: ${exp.companyField}'),
                verticalSpace(5),
                Text('Type: ${exp.jobType}'),
                verticalSpace(5),
                Text('Location: ${exp.jobLocation}'),
                verticalSpace(5),
                Text('Dates: ${exp.startDate} - ${exp.endDate}'),
                verticalSpace(5),
                Text('Summary: ${exp.summary}'),
                verticalSpace(5),
                if (exp.toolsTechnologiesUsed.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    children: exp.toolsTechnologiesUsed
                        .map((tool) => Chip(label: Text(tool)))
                        .toList(),
                  ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      scaffoldMessenger.hideCurrentSnackBar();
                      viewModel.removeWorkExperience(exp);

                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text('${exp.jobTitle} removed!'),
                          backgroundColor: Colors.red,
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              scaffoldMessenger.hideCurrentSnackBar();
                              viewModel.addWorkExperienceBack(exp);
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text('${exp.jobTitle} restored!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
