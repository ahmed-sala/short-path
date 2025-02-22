import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/user_info/skill_gathering/skill_gathering_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/skill_gathering/skill_gathering_viewmodel.dart';

class TechSkillListWidget extends StatelessWidget {
  const TechSkillListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SkillGatheringViewmodel, SkillGatheringState>(
      builder: (context, state) {
        final skills = context.read<SkillGatheringViewmodel>().techSkills;
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
              label: Text('${skill.skill} (${skill.proficiency})'),
              backgroundColor: AppColors.whiteColor,
              labelStyle: const TextStyle(color: AppColors.primaryColor),
              deleteIcon: const Icon(Icons.close, color: Colors.red),
              onDeleted: () {
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                scaffoldMessenger
                    .hideCurrentSnackBar(); // Remove previous SnackBar
                context.read<SkillGatheringViewmodel>().removeSkill(
                    type: 'Technical',
                    skill: skill.skill!,
                    proficiency: skill.proficiency);

                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text('${skill.skill} removed successfully!'),
                    backgroundColor: Colors.red,
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        scaffoldMessenger
                            .hideCurrentSnackBar(); // Remove previous SnackBar
                        context.read<SkillGatheringViewmodel>().addSkill(
                            type: 'Technical',
                            skill: skill.skill!,
                            proficiency: skill.proficiency);
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text('${skill.skill} added back!'),
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
