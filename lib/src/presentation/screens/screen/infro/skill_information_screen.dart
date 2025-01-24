import 'package:flutter/material.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/infromation_gathering/skill_gathering/skill_gathering_viewmodel.dart';

class SkillInformationScreen extends StatelessWidget {
  const SkillInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SkillGatheringViewmodel skillGatheringViewmodel =
        getIt<SkillGatheringViewmodel>();
    final PageController _pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill Information'),
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          skillGatheringViewmodel.changePage(index);
        },
        itemCount: skillGatheringViewmodel.pages.length,
        itemBuilder: (context, index) {
          return skillGatheringViewmodel.pages[index];
        },
      ),
    );
  }
}
