import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/data/static_data/demo_data_list.dart';
import 'package:short_path/src/presentation/mangers/user_info/skill_gathering/skill_gathering_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/skill_gathering/skill_gathering_viewmodel.dart';

class SoftSkillListWidget extends StatelessWidget {
  const SoftSkillListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SkillGatheringViewmodel, SkillGatheringState>(
      builder: (context, state) {
        final skills = context.read<SkillGatheringViewmodel>().softSkills;
        if (skills.isEmpty) {
          return Text(
            context.localization.noSkillsAddedYetStartByAddingSomeSkills,
            style: const TextStyle(color: Colors.grey),
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
                context.read<SkillGatheringViewmodel>().removeSkill(
                      type: 'Soft',
                      skill: skill,
                    );
                softSkills.add(skill);
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text(
                        '$skill ${context.localization.removedSuccessfully}'),
                    backgroundColor: Colors.red,
                    action: SnackBarAction(
                      label: context.localization.undo,
                      onPressed: () {
                        Fluttertoast.cancel();
                        scaffoldMessenger
                            .hideCurrentSnackBar(); // Dismiss previous SnackBar
                        context.read<SkillGatheringViewmodel>().addSkill(
                              type: 'Soft',
                              skill: skill,
                            );
                        softSkills.remove(skill);
                        Fluttertoast.showToast(
                            msg: '$skill ${context.localization.addedBack}');
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
