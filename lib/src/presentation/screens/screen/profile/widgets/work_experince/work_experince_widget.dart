import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';
import 'package:short_path/src/presentation/screens/screen/profile/widgets/work_experince/work_experince_card.dart';

class WorkExperienceWidget extends StatelessWidget {
  const WorkExperienceWidget({super.key});

  String _formatDate(DateTime date) => DateFormat.yMMM().format(date);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        final cubit = context.read<PersonalProfileCubit>();
        final workExperiences = cubit.workExperienceEntity;

        if (workExperiences == null || workExperiences.isEmpty) {
          return Center(
              child: Text(context.localization.noWorkExperienceAvailable));
        }
        if (state is WorkExperienceLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: workExperiences.map((work) {
                final String duration = work.endDate != null
                    ? '${_formatDate(work.startDate)} - ${_formatDate(work.endDate!)}'
                    : '${_formatDate(work.startDate)} - ${context.localization.present}';

                return WorkExperienceCard(work: work, duration: duration);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
