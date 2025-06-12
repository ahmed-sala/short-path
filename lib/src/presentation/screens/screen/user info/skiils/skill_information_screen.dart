import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/dialogs/show_hide_loading.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/user_info/skill_gathering/skill_gathering_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/skill_gathering/skill_gathering_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/next_back_buttuns.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../shared_widgets/progress_bar.dart';
import '../../../widgets/user info/profile/header_widget.dart';
import 'next_back_buttons.dart';

class SkillInformationScreen extends StatelessWidget {
  const SkillInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (_) => getIt<SkillGatheringViewmodel>(),
        child: BlocConsumer<SkillGatheringViewmodel, SkillGatheringState>(
          listenWhen: (prev, curr) =>
          curr is! SkillPageChangedState && curr is! SkillAddedState && curr is! SkillRemovedState,
          listener: (context, state) {
            if (state is SkillsAddedSuccessState) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(RoutesName.education, (_) => false);
            }
            if (state is SkillsAddedFailureState) {
              showAwesomeDialog(
                context,
                title: context.localization.error,
                desc: state.message,
                onOk: () {},
                dialogType: DialogType.error,
              );
            }
            if (state is SkillsAddedLoadingState) {
              showLoading(context, context.localization.addingSkills);
            }
          },
          builder: (context, state) {
            final vm = context.read<SkillGatheringViewmodel>();


            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: HeaderWidget()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: StepProgressBar(
                    currentStep: 2,
                    stepNames: [
                      context.localization.personalInfo,
                      context.localization.skills,
                      context.localization.education,
                      context.localization.experience,
                      context.localization.projects,
                      context.localization.certifications,
                      context.localization.additionalInfo,
                    ],
                  ),
                ),
                verticalSpace(10),
                Expanded(
                  child: PageView.builder(
                    controller: vm.pageController,
                    onPageChanged: vm.changePage,
                    itemCount: vm.pages.length,
                    itemBuilder: (context, index) => vm.pages[index],
                  ),
                ),
                NextBackButtons(
                  currentPage: vm.currentPage,
                  length: vm.pages.length,
                  onNext: vm.currentPage < vm.pages.length - 1
                      ? vm.nextPage
                      : vm.addAllSkills,
                  onBack: vm.previousPage,
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
