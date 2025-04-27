import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../core/common/common_imports.dart';
import '../../../../../mangers/profile/personal_profile_viewmodel.dart';
import 'language_proficiency_row.dart';

class LanguagesWidget extends StatelessWidget {
  const LanguagesWidget({Key? key}) : super(key: key);

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

        return Skeletonizer(
          child: Padding(
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
          ),
        );
      },
    );
  }
}
