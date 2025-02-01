import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/user_info/Language/language_viewmodel.dart';

import '../../../../mangers/user_info/profile/profile_state.dart';
import '../../../../mangers/user_info/profile/profile_viewmodel.dart';

class LanguageListWidget extends StatelessWidget {
  const LanguageListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageViewModel, LanguageState>(
      builder: (context, state) {
        final languages = context.read<LanguageViewModel>().languages;
        print(languages);
        if (languages.isEmpty) {
          return const Text(
            'No languages added yet. Start by adding some skills.',
            style: TextStyle(color: Colors.grey),
          );
        }
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: languages.map((skill) {
            return Chip(
              label: Text('${skill.language} (${skill.level})'),
              backgroundColor: AppColors.whiteColor,
              labelStyle: const TextStyle(color: AppColors.primaryColor),
              deleteIcon: const Icon(Icons.close, color: Colors.red),
              onDeleted: () {
                // Use ScaffoldMessenger to manage SnackBars
                final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
                if (scaffoldMessenger == null) {
                  debugPrint('ScaffoldMessenger not found in the widget tree.');
                  return;
                }

                scaffoldMessenger
                    .hideCurrentSnackBar(); // Dismiss any previous SnackBar
                context.read<LanguageViewModel>().removeLanguage(skill);

                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text('$skill removed successfully!'),
                    backgroundColor: Colors.red,
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        scaffoldMessenger
                            .hideCurrentSnackBar(); // Dismiss previous SnackBar
                        context
                            .read<LanguageViewModel>()
                            .addLanguage(skill.language, skill.level);
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text('$skill added back!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
