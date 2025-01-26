import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';

import '../../../../../../dependency_injection/di.dart';
import '../../../../mangers/infromation_gathering/skill_gathering/skill_gathering_viewmodel.dart';
import '../../../widgets/user info/skill_gathering/industry_specfic/industry_skill_input_widget.dart';
import '../../../widgets/user info/skill_gathering/industry_specfic/industry_skill_list_widget.dart';

class IndustrySpecificSkillsScreen extends StatelessWidget {
  const IndustrySpecificSkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SkillGatheringViewmodel skillGatheringViewmodel =
        getIt<SkillGatheringViewmodel>();
    return BlocProvider(
      create: (context) => skillGatheringViewmodel,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Industry Specific Skills',
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
                child: IndustrySkillInputWidget(),
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
            const IndustrySkillListWidget(),
          ],
        ),
      ),
    );
  }
}
