import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';

class SkillsWidget extends StatelessWidget {
  const SkillsWidget({Key? key}) : super(key: key);

  Widget _buildSkillChip(String skill) {
    return Chip(
      label: Text(skill, style: TextStyle(color: AppColors.primaryColor)),
      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.primaryColor.withOpacity(0.5)),
      ),
    );
  }

  Widget _buildTechnicalSkill(String skill, String proficiency) {
    double progress = _getProficiencyLevel(proficiency);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(skill,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
          minHeight: 6,
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  double _getProficiencyLevel(String proficiency) {
    switch (proficiency.toLowerCase()) {
      case 'beginner':
        return 0.3;
      case 'intermediate':
        return 0.6;
      case 'advanced':
        return 0.9;
      case 'expert':
        return 1.0;
      default:
        return 0.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        final cubit = context.read<PersonalProfileCubit>();
        final skills = cubit.skillEntity;

        if (skills == null) {
          return const Center(child: Text('No skills available.'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Technical Skills',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...skills.technicalSkills.map(
                (skill) =>
                    _buildTechnicalSkill(skill.skill!, skill.proficiency!),
              ),
              const Divider(height: 24),
              const Text(
                'Soft Skills',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: skills.softSkills
                    .map((skill) => _buildSkillChip(skill))
                    .toList(),
              ),
              const Divider(height: 24),
              const Text(
                'Industry-Specific Skills',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: skills.industrySpecificSkills
                    .map((skill) => _buildSkillChip(skill))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
