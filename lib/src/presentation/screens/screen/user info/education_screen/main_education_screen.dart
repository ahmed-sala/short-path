import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/src/presentation/screens/screen/user%20info/education_screen/detailed_education.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/education/education_list.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../../../core/dialogs/awesome_dialoge.dart';
import '../../../../../../core/dialogs/show_hide_loading.dart';
import '../../../../../../dependency_injection/di.dart';
import '../../../../mangers/user_info/education/education_state.dart';
import '../../../../mangers/user_info/education/education_viewmodel.dart';

class MainEducationScreen extends StatelessWidget {
  const MainEducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EducationViewmodelNew>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Education'),
        ),
        body: BlocConsumer<EducationViewmodelNew, EducationState>(
          listener: (context, state) {
            if (state is AddEducationLoadingState) {
              showLoading(context, 'Adding Educations');
            }
            if (state is AddEducationErrorState) {
              showAwesomeDialog(context,
                  title: 'Error',
                  desc: state.message,
                  onOk: () {},
                  dialogType: DialogType.error);
            }
            if (state is AddEducationSuccessState) {
              navKey.currentState!
                  .pushReplacementNamed(RoutesName.certification);
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
            if (state is EducationAddedState ||
                state is RemoveEducationState ||
                state is EducationInitialState ||
                state is OnboardingNextState ||
                state is UpdateSelectedDateState ||
                state is EducationProjectUpdated ||
                state is ProjectDescriptionChanged ||
                state is ProjectLinkChanged ||
                state is ToolsTechnologiesChanged ||
                state is ProjectNameChanged ||
                state is ValidateColorButtonState ||
                state is DateUpdatedState ||
                state is ToolsAndTechnologiesAdded ||
                state is ToolsAndTechnologiesRemoved ||
                state is ToolsAndTechnologiesSelected ||
                state is ToolsTechnologiesChanged ||
                state is AddEducationLoadingState ||
                state is AddEducationSuccessState ||
                state is AddEducationErrorState) {
              return Column(
                children: [
                  EducationListWidget(),
                  Expanded(child: DetailedEducation()),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
