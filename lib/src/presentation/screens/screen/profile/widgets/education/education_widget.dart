import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/extensions/extensions.dart';

import '../../../../../../../core/common/common_imports.dart';
import '../../../../../mangers/profile/personal_profile_viewmodel.dart';
import 'education_card.dart';

class EducationWidget extends StatelessWidget {
  const EducationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        final cubit = context.read<PersonalProfileCubit>();
        final educationDetails = cubit.educationEntity?.educationDetails;

        if (educationDetails == null || educationDetails.isEmpty) {
          return Center(
              child: Text(context.localization.noEducationDetailsAvailable));
        }
        if (state is EducationLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: educationDetails
                  .map((education) => EducationCard(education: education))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
