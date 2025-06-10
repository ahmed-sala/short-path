import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/dialogs/show_hide_loading.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_viewmodel.dart';
import 'package:short_path/src/presentation/screens/screen/user%20info/education_screen/detailed_education.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/education/education_list.dart';
import 'package:short_path/src/presentation/shared_widgets/progress_bar.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../../../core/styles/spacing.dart';
import '../../../widgets/user info/profile/header_widget.dart';

class MainEducationScreen extends StatelessWidget {
  const MainEducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EducationViewmodelNew>(),
      child: Scaffold(
        body: BlocConsumer<EducationViewmodelNew, EducationState>(
          listener: (context, state) {
            if (state is AddEducationLoadingState) {
              showLoading(context, context.localization.addingEducations);
            }
            if (state is AddEducationErrorState) {
              showAwesomeDialog(context,
                  title: context.localization.error,
                  desc: state.message,
                  onOk: () {},
                  dialogType: DialogType.error);
            }
            if (state is AddEducationSuccessState) {
              navKey.currentState!.pushNamedAndRemoveUntil(
                  RoutesName.workExperience, (route) => false);
            }
          },
          listenWhen: (previous, current) {
            if (previous is AddEducationLoadingState ||
                current is AddEducationErrorState) {
              hideLoading();
            }
            return current is! EducationInitialState;
          },
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  verticalSpace(40),
                  const Center(child: HeaderWidget()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: StepProgressBar(
                      currentStep: 3,
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
                  verticalSpace(16),
                  const EducationListWidget(),
                  const Expanded(
                    flex: 2,
                    child: DetailedEducation(),
                  ),
                  verticalSpace(20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
