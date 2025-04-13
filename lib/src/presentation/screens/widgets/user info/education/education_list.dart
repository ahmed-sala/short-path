import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_viewmodel.dart';

import '../../../../shared_widgets/toast_dialoge.dart';

class EducationListWidget extends StatelessWidget {
  const EducationListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationViewmodelNew, EducationState>(
      builder: (context, state) {
        final skills = context.read<EducationViewmodelNew>().educationDetails;
        if (skills.isEmpty) {
          return Text(
            context.localization.nothingAddedYet,
            style: const TextStyle(color: Colors.grey),
          );
        }
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) {
            return Chip(
              label: Text(skill.institutionName!),
              backgroundColor: AppColors.whiteColor,
              labelStyle: const TextStyle(color: AppColors.primaryColor),
              deleteIcon: const Icon(Icons.close, color: Colors.red),
              onDeleted: () {
                // Use ScaffoldMessenger to manage SnackBars
                final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
                if (scaffoldMessenger == null) {
                  debugPrint('ScaffoldMessenger not found in the widget tree.');
                  return;
                }

                scaffoldMessenger
                    .hideCurrentSnackBar(); // Dismiss any previous SnackBar
                context.read<EducationViewmodelNew>().removeEducation(skill);
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text(
                        '${skill.institutionName} ${context.localization.removedSuccessfully}'),
                    backgroundColor: Colors.red,
                    action: SnackBarAction(
                      label: context.localization.undo,
                      onPressed: () {
                        Fluttertoast.cancel();
                        scaffoldMessenger
                            .hideCurrentSnackBar(); // Dismiss previous SnackBar
                        context.read<EducationViewmodelNew>().addEducation();

                        ToastDialog.show(
                            '${skill.institutionName} ${context.localization.addedBack}',
                            Colors.green);
                      },
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
