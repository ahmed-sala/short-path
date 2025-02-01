import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/shared_widgets/next_back_buttuns.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../../../config/routes/routes_name.dart';
import '../../../../mangers/user_info/skill_gathering/skill_gathering_state.dart';
import '../../../../mangers/user_info/skill_gathering/skill_gathering_viewmodel.dart';

class SkillInformationScreen extends StatefulWidget {
  const SkillInformationScreen({super.key});

  @override
  _SkillInformationScreenState createState() => _SkillInformationScreenState();
}

class _SkillInformationScreenState extends State<SkillInformationScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill Information'),
      ),
      body: BlocProvider(
        create: (context) => getIt<SkillGatheringViewmodel>(),
        child: BlocBuilder<SkillGatheringViewmodel, SkillGatheringState>(
          builder: (context, state) {
            final skillGatheringViewmodel =
                context.read<SkillGatheringViewmodel>();

            return Column(
              children: [
                // PageView with pageController
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      // Update ViewModel when page changes
                      skillGatheringViewmodel.changePage(index);
                    },
                    itemCount: skillGatheringViewmodel.pages.length,
                    itemBuilder: (context, index) {
                      return skillGatheringViewmodel.pages[index];
                    },
                  ),
                ),
                // NextBackButtons widget for navigation
                NextBackButtuns(
                  finish: () {
                    navKey.currentState!
                        .pushReplacementNamed(RoutesName.education);
                  },
                  pageController: _pageController,
                  length: skillGatheringViewmodel.pages.length,
                  changePage: skillGatheringViewmodel.changePage,
                  currentPage: skillGatheringViewmodel.currentPage,
                ),
                verticalSpace(24),
              ],
            );
          },
        ),
      ),
    );
  }
}
