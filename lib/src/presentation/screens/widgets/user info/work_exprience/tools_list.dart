import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/data/static_data/demo_data_list.dart';
import 'package:short_path/src/presentation/mangers/user_info/work_experience/work_experience_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/work_experience/work_experience_viewmodel.dart';

class ToolsList extends StatelessWidget {
  const ToolsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkExperienceViewModel, WorkExperienceState>(
      builder: (context, state) {
        final skills =
            context.read<WorkExperienceViewModel>().toolsTechnologiesUsed;
        if (skills.isEmpty) {
          return const Text(
            'No skills added yet. Start by adding some skills.',
            style: TextStyle(color: Colors.grey),
          );
        }
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) {
            return Chip(
              label: Text(skill),
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
                context.read<WorkExperienceViewModel>().removeTool(
                      skill,
                    );
                softSkills.add(skill);
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text('$skill removed successfully!'),
                    backgroundColor: Colors.red,
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        scaffoldMessenger
                            .hideCurrentSnackBar(); // Dismiss previous SnackBar
                        context.read<WorkExperienceViewModel>().addTool(
                              skill,
                            );
                        softSkills.remove(skill);
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text('$skill added back!'),
                            backgroundColor: Colors.green,
                          ),
                        );
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
