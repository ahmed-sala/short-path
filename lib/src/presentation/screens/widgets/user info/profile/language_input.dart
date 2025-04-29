import 'package:flutter/material.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/user_info/Language/language_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_drop_downButton_form_field.dart';

import '../../../../shared_widgets/suggetion_list.dart';

class LanguageInput extends StatefulWidget {
  const LanguageInput({super.key, required this.viewModel});
  final LanguageViewmodel viewModel;

  @override
  State<LanguageInput> createState() => _LanguageInputState();
}

class _LanguageInputState extends State<LanguageInput> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.languageController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      widget.viewModel.onLanguageChanged();
    });
  }

  @override
  void dispose() {
    widget.viewModel.languageController.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                hintText: context.localization.enterALanguage,
                keyboardType: TextInputType.text,
                controller: widget.viewModel.languageController,
                labelText: context.localization.language,
                validator: (String? text) => null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomDropdownButtonFormField<String>(
                labelText: context.localization.level,
                items: widget.viewModel.languageLevels
                    .map((level) => DropdownMenuItem(
                          value: level,
                          child: Text(level),
                        ))
                    .toList(),
                value: widget.viewModel.selectedLanguageLevel,
                onChanged: widget.viewModel.selectLanguageLevel,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (widget.viewModel.languageController.text.isNotEmpty &&
                    widget.viewModel.selectedLanguageLevel != null) {
                  widget.viewModel.addLanguage(
                    widget.viewModel.languageController.text,
                    widget.viewModel.selectedLanguageLevel!,
                  );
                  widget.viewModel.languageController.clear();
                  widget.viewModel.selectLanguageLevel('Beginner');
                  setState(() {}); // Refresh the suggestion list
                }
              },
              color: AppColors.primaryColor,
            ),
          ],
        ),

        /// Suggestions section
        if (widget.viewModel.filteredLanguageSuggestions.isNotEmpty)
          SuggestionList(
            suggestions: widget.viewModel.filteredLanguageSuggestions,
            onTap: (selected) {
              widget.viewModel.languageController.text = selected;
              widget.viewModel.filteredLanguageSuggestions = [];
              setState(() {});
            },
          ),
      ],
    );
  }
}
