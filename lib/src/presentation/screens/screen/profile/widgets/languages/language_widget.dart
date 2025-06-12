import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../core/common/common_imports.dart';
import '../../../../../mangers/profile/personal_profile_viewmodel.dart';
import 'language_proficiency_row.dart';

class LanguagesWidget extends StatelessWidget {
  const LanguagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        final cubit = context.read<PersonalProfileCubit>();
        final languages = cubit.languageEntity;

        if (languages == null || languages.isEmpty) {
          return Center(child: Text(context.localization.noLanguagesAvailable));
        }
        if (state is LanguagesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: languages
                .map((lang) => LanguageProficiencyRow(
                      language: lang.language,
                      level: lang.level,
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
