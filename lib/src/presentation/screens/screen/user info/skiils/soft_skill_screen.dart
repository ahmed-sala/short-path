import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/styles/colors/app_colore.dart';
import '../../../../mangers/user_info/skill_gathering/skill_gathering_viewmodel.dart';
import '../../../widgets/user info/skill_gathering/soft_skills/soft_skill_input_widget.dart';
import '../../../widgets/user info/skill_gathering/soft_skills/soft_skill_list_widget.dart';

class SoftSkillScreen extends StatelessWidget {
  const SoftSkillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SkillGatheringViewmodel skillGatheringViewmodel =
        context.read<SkillGatheringViewmodel>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Soft Skills',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SoftSkillInputWidget(),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Your Skills',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          const SoftSkillListWidget(),
        ],
      ),
    );
  }
}
