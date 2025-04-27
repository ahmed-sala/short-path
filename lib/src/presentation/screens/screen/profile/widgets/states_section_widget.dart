import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';
import 'package:short_path/src/presentation/screens/screen/profile/widgets/state_item_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../core/common/common_imports.dart';

class StatesSectionWidget extends StatelessWidget {
  const StatesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        var viewModel = context.read<PersonalProfileCubit>();
        final profile = viewModel.profileEntity;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Skeletonizer(
                enabled: profile?.projectsCompleted == null,
                child: StateItemWidget(
                  label: context.localization.projects,
                  value: profile?.projectsCompleted.toString() ?? '',
                ),
              ),
              Skeletonizer(
                enabled: profile?.yearOfExperience == null,
                child: StateItemWidget(
                  label: context.localization.experience,
                  value: profile?.yearOfExperience != null
                      ? '${profile!.yearOfExperience} ${context.localization.yrs}'
                      : '',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
