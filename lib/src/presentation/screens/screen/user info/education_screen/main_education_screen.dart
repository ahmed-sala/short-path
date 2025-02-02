import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/src/presentation/screens/screen/user%20info/education_screen/detailed_education.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/education/education_list.dart';

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
        body: BlocBuilder<EducationViewmodelNew, EducationState>(
          builder: (context, state) {
            if (state is EducationAddedState ||
                state is RemoveEducationState ||
                state is EducationInitialState ||
                state is OnboardingNextState ||
                state is UpdateSelectedDateState) {
              return Column(
                children: [
                  EducationListWidget(),
                  verticalSpace(20),
                  Text(
                    'Add your education details',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  verticalSpace(20),
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
