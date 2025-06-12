import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/user_info/Language/language_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_drop_downButton_form_field.dart';

import '../../../../../data/static_data/demo_data_list.dart';
import '../../../../shared_widgets/suggetion_list.dart';
import '../../../../shared_widgets/toast_dialoge.dart';

class LanguageInput extends StatefulWidget {
  const LanguageInput({super.key});

  @override
  _LanguageInputState createState() => _LanguageInputState();
}

class _LanguageInputState extends State<LanguageInput> {
  bool _showSuggestions = false;

  /// build the list of labels the user actually sees
  List<String> get _displayLevels => [
    context.localization.beginner,
    context.localization.intermediate,
    context.localization.advanced,
    context.localization.fluent,
    context.localization.native,
  ];
  /// Map from whatever the user sees → the API enum
  Map<String,String> get _displayToApi => {
    context.localization.beginner:     'Beginner',
    context.localization.intermediate: 'Intermediate',
    context.localization.advanced:     'Advanced',
    context.localization.fluent:       'Fluent',
    context.localization.native:       'Native',
  };
  @override
  Widget build(BuildContext context) {
    final vm = context.read<LanguageViewmodel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // 1) Language text field
            Expanded(
              child: CustomTextFormField(
                labelText: context.localization.language,
                hintText: context.localization.enterALanguage,
                controller: vm.languageController,
                keyboardType: TextInputType.text,
                validator: (_) => null,
                onChanged: (value) {
                  final suggestions = languageSuggestions
                      .where((lang) =>
                          lang.toLowerCase().startsWith(value.toLowerCase()))
                      .toList();
                  setState(() {
                    vm.filteredLanguageSuggestions = suggestions;
                    _showSuggestions = value.isNotEmpty;
                  });
                },
              ),
            ),

            const SizedBox(width: 8),

            // 2) Level dropdown
            Expanded(
              child: CustomDropdownButtonFormField<String>(
                labelText: context.localization.level,
                hintText: context.localization.selectLevel,
                value: vm.selectedLanguageLevel,
                items: _displayLevels
                    .map((lvl) => DropdownMenuItem(
                          value: lvl,
                          child: Text(lvl),
                        ))
                    .toList(),
                onChanged: (lvl) {
                  setState(() {
                    vm.selectedLanguageLevel = lvl;
                    print("selectedLanguageLevel: '$lvl'");
                  });
                },
              ),
            ),

            const SizedBox(width: 8),

            // 3) Add button
            IconButton(
              icon: const Icon(Icons.add_circle, size: 30),
              color: AppColors.primaryColor,
              onPressed: () {
                Fluttertoast.cancel();
                final raw = vm.languageController.text.trim();
                final displayLevel = vm.selectedLanguageLevel;

                // must pick a level
                if (displayLevel == null) {
                  ToastDialog.show(
                    context.localization.pleaseSelectALevel,
                    Colors.red,
                  );
                  return;
                }

                // attempt add (VM will toast for invalid or duplicates)
                final apiLevel = _displayToApi[displayLevel]!;
                print("apiLevel: '$apiLevel'");
                vm.addLanguage(raw, apiLevel);

                // if added, VM.languages now contains it → show success
                if (vm.languages.any((e) => e.language == raw)) {
                  ToastDialog.show(
                    '${context.localization.languageAddedSuccessfully} $raw',
                    Colors.green,
                  );
                  // clear for next
                  vm.languageController.clear();
                  setState(() {
                    vm.selectedLanguageLevel = null;
                    vm.filteredLanguageSuggestions = [];
                    _showSuggestions = false;
                  });
                }
              },
            ),
          ],
        ),

        // 4) Suggestions
        if (_showSuggestions && vm.filteredLanguageSuggestions.isNotEmpty)
          SuggestionList(
            suggestions: vm.filteredLanguageSuggestions,
            onTap: (lang) {
              vm.languageController.text = lang;
              setState(() => _showSuggestions = false);
            },
          ),
      ],
    );
  }
}
