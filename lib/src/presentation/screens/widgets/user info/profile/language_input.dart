import 'package:flutter/material.dart';

import '../../../../../../core/styles/colors/app_colore.dart';
import '../../../../mangers/user_info/profile/profile_viewmodel.dart';
import '../../../../shared_widgets/custom_auth_text_feild.dart';
import '../../../../shared_widgets/custom_drop_downButton_form_field.dart';

class LanguageInput extends StatelessWidget {
  const LanguageInput({super.key, required this.viewModel});
  final ProfileViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CustomTextFormField(
            hintText: 'Enter a language',
            keyboardType: TextInputType.text,
            controller: viewModel.languageController,
            labelText: 'Language',
            validator: (String? text) {
              return null;
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: CustomDropdownButtonFormField(
            labelText: 'Level',
            items: viewModel.languageLevels
                .map((level) => DropdownMenuItem(
                      child: Text(level),
                      value: level,
                    ))
                .toList(),
            value: viewModel.selectedLanguageLevel,
            onChanged: viewModel.selectLanguageLevel,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            if (viewModel.languageController.text.isNotEmpty &&
                viewModel.selectedLanguageLevel != null) {
              viewModel.addLanguage(
                viewModel.languageController.text,
                viewModel.selectedLanguageLevel!,
              );
              viewModel.languageController.clear();
              viewModel.selectLanguageLevel('Beginner');
            }
          },
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}
