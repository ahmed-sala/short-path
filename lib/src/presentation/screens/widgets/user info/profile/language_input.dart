import 'package:flutter/material.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/user_info/Language/language_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_drop_downButton_form_field.dart';

class LanguageInput extends StatelessWidget {
  const LanguageInput({super.key, required this.viewModel});
  final LanguageViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            hintText: context.localization.enterALanguage,
            keyboardType: TextInputType.text,
            controller: viewModel.languageController,
            labelText: context.localization.language,
            validator: (String? text) {
              return null;
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomDropdownButtonFormField<String>(
            labelText: context.localization.level,
            items: viewModel.languageLevels
                .map((level) => DropdownMenuItem(
                      value: level,
                      child: Text(level),
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
