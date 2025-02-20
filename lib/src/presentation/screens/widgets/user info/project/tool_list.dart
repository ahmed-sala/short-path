import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/user_info/Project/Project_State.dart';
import 'package:short_path/src/presentation/mangers/user_info/Project/Project_Viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/toast_dialoge.dart';

class ToolList extends StatelessWidget {
  const ToolList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectViewmodel, ProjectState>(
      builder: (context, state) {
        final skills = context.read<ProjectViewmodel>().toolsTechnologies;
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
                context.read<ProjectViewmodel>().removeToolsTechnologies(
                      skill,
                    );
                ToastDialog.show('$skill removed', Colors.red);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
