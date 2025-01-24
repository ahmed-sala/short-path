import 'package:flutter/material.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/infromation_gathering/skill_gathering/skill_gathering_viewmodel.dart';
import 'package:short_path/src/presentation/screens/screen/infro/technical_skill_screen.dart';

class SkillInformationScreen extends StatelessWidget {
  const SkillInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SkillGatheringViewmodel skillGatheringViewmodel =
        getIt<SkillGatheringViewmodel>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Skill Information'),
        ),
        body: const TechnicalSkillScreen());
  }
}
