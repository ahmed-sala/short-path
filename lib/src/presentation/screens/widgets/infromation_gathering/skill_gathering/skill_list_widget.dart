import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../mangers/infromation_gathering/skill_gathering/skill_gathering_state.dart';
import '../../../../mangers/infromation_gathering/skill_gathering/skill_gathering_viewmodel.dart';

class SkillListWidget extends StatelessWidget {
  const SkillListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SkillGatheringViewmodel, SkillGatheringState>(
      builder: (context, state) {
        final skills = context.read<SkillGatheringViewmodel>().skills;
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
              backgroundColor: Colors.indigo.withOpacity(0.1),
              labelStyle: const TextStyle(color: Colors.indigo),
              deleteIcon: const Icon(Icons.close, color: Colors.red),
              onDeleted: () {
                context.read<SkillGatheringViewmodel>().removeSkill(skill);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${skill.skill} removed successfully!'),
                    backgroundColor: Colors.red,
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        context.read<SkillGatheringViewmodel>().addSkill(skill);
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
