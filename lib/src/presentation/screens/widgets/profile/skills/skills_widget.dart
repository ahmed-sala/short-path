import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/skills/tech_skills_widget.dart';

import '../../../../../../core/common/common_imports.dart';
import '../../../../mangers/profile/personal_profile_viewmodel.dart';
import '../profile_shared_widgets.dart';

class SkillsWidget extends StatelessWidget {
  const SkillsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        final cubit = context.read<PersonalProfileCubit>();
        final skills = cubit.skillEntity;

        if (skills == null) {
          return const Center(child: Text('No skills available.'));
        }
        if (state is SkillsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableWidgets.sectionTitle('Technical Skills', Icons.build),
              const SizedBox(height: 12),
              ...skills.technicalSkills.map(
                (skill) => TechnicalSkillWidget(
                  skill: skill.skill!,
                  proficiency: skill.proficiency!,
                ),
              ),
              const Divider(height: 24),
              ReusableWidgets.sectionTitle(
                  'Soft Skills', Icons.sentiment_satisfied),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: skills.softSkills
                    .map((skill) => ReusableWidgets.buildChip(skill))
                    .toList(),
              ),
              const Divider(height: 24),
              ReusableWidgets.sectionTitle(
                  'Industry-Specific Skills', Icons.business),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: skills.industrySpecificSkills
                    .map((skill) => ReusableWidgets.buildChip(skill))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
