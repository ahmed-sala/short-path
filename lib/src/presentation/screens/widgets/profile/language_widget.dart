import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';

import '../../../../../core/functions/flag_helper.dart';

class LanguagesWidget extends StatelessWidget {
  const LanguagesWidget({Key? key}) : super(key: key);

  Widget _buildLanguageProficiency(String language, String level) {
    double progress = _getProficiencyLevel(level);
    return Row(
      children: [
        FlagHelper.getFlag(language),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                minHeight: 6,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }

  double _getProficiencyLevel(String level) {
    switch (level.toLowerCase()) {
      case 'beginner':
        return 0.3;
      case 'intermediate':
        return 0.6;
      case 'advanced':
        return 0.9;
      case 'native':
      case 'fluent':
        return 1.0;
      default:
        return 0.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        final cubit = context.read<PersonalProfileCubit>();
        final languages = cubit.languageEntity;

        if (languages == null || languages.isEmpty) {
          return const Center(child: Text('No languages available.'));
        }
        if (state is LanguagesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              ...languages.map(
                (language) => _buildLanguageProficiency(
                    language.language, language.level),
              ),
            ],
          ),
        );
      },
    );
  }
}
