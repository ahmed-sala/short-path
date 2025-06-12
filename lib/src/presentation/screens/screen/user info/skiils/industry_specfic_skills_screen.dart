import 'package:flutter/material.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/skill_gathering/industry_specfic/industry_skill_input_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/skill_gathering/industry_specfic/industry_skill_list_widget.dart';

class IndustrySpecificSkillsScreen extends StatelessWidget {
  const IndustrySpecificSkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.localization.industrySpecificSkills,
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
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: IndustrySkillInputWidget(),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            context.localization.yourSkills,
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
    );
  }
}
