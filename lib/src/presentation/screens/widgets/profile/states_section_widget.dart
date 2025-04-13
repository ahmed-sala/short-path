import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/state_item_widget.dart';

import '../../../../../core/common/common_imports.dart';

class StatesSectionWidget extends StatelessWidget {
  const StatesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<PersonalProfileCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StateItemWidget(
            label: context.localization.projects,
            value: viewModel.profileEntity!.projectsCompleted.toString(),
          ),
          StateItemWidget(
            label: context.localization.experience,
            value:
                '${viewModel.profileEntity?.yearOfExperience.toString()} ${context.localization.yrs}',
          ),
        ],
      ),
    );
  }
}
