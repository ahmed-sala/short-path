import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/user_info/Language/language_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/Language/language_viewmodel.dart';

import '../../../../shared_widgets/toast_dialoge.dart';

class LanguageListWidget extends StatelessWidget {
  const LanguageListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageViewmodel, LanguageState>(
      builder: (context, state) {
        final languages = context.read<LanguageViewmodel>().languages;
        print(languages);
        if (languages.isEmpty) {
          return Text(
            context.localization.nothingAddedYet,
            style: const TextStyle(color: Colors.grey),
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
                final languageViewmodel = context.read<LanguageViewmodel>();
                final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
                if (scaffoldMessenger == null) {
                  debugPrint('ScaffoldMessenger not found in the widget tree.');
                  return;
                }
                scaffoldMessenger.hideCurrentSnackBar();
                languageViewmodel.removeLanguage(skill);

                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text(
                        '$skill ${context.localization.removedSuccessfully}'),
                    backgroundColor: Colors.red,
                    action: SnackBarAction(
                      label: context.localization.undo,
                      onPressed: () {
                        Fluttertoast.cancel();
                        scaffoldMessenger.hideCurrentSnackBar();
                        // Use the stored languageViewmodel reference.
                        languageViewmodel.addLanguage(
                            skill.language, skill.level);
                        ToastDialog.show(
                            context.localization.addedBack, Colors.green);
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
