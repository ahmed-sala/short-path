import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/data/static_data/demo_data_list.dart';
import 'package:short_path/src/presentation/mangers/user_info/skill_gathering/skill_gathering_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_drop_downButton_form_field.dart';

import '../../../../../shared_widgets/suggetion_list.dart';
import '../../../../../shared_widgets/toast_dialoge.dart';

class TechSkillInputWidget extends StatefulWidget {
  const TechSkillInputWidget({super.key});

  @override
  _TechSkillInputWidgetState createState() => _TechSkillInputWidgetState();
}

class _TechSkillInputWidgetState extends State<TechSkillInputWidget> {
  bool _showSuggestions = false;
  /// build the list of labels the user actually sees
  List<String> get _displayLevels => [
    context.localization.beginner,
    context.localization.intermediate,
    context.localization.advanced,
    context.localization.expert
  ];
  /// Map from whatever the user sees → the API enum
  Map<String,String> get _displayToApi => {
    context.localization.beginner:     'Beginner',
    context.localization.intermediate: 'Intermediate',
    context.localization.advanced:     'Advanced',
    context.localization.expert:       'Expert',
  };

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SkillGatheringViewmodel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Skill Input
            Expanded(
              child: CustomTextFormField(
                labelText: context.localization.skill,
                hintText: context.localization.enterYourSkill,
                keyboardType: TextInputType.text,
                controller: viewModel.techSkillController,
                validator: (value) {
                  return null;
                },
                onChanged: (value) {
                  final filteredSkills = technicalSkills
                      .where((skill) =>
                          skill.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                  setState(() {
                    viewModel.filteredSuggestions = filteredSkills;
                    _showSuggestions = value.isNotEmpty;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            // Proficiency Dropdown
            Expanded(
              child: CustomDropdownButtonFormField<String>(
                labelText: context.localization.proficiency,
                hintText: context.localization.selectProficiency,
                value: viewModel.selectedProficiency,
                onChanged: (String? newValue) {
                  setState(() {
                    viewModel.selectedProficiency = newValue!;
                    print("selectedProficiency: '${viewModel.selectedProficiency}'");
                  });
                },
                items: _displayLevels
                    .map((value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(width: 8),
            // Add Skill Icon Button
            IconButton(
              icon: const Icon(Icons.add_circle,
                  color: AppColors.primaryColor, size: 30),
              onPressed: () {
                Fluttertoast.cancel();
                final raw = viewModel.techSkillController.text.trim();
                final skill = raw.toLowerCase();

                // 1) Validate it’s in the master list
                if (!technicalSkills
                    .map((s) => s.toLowerCase())
                    .contains(skill)) {
                  ToastDialog.show(
                    context.localization
                        .pleaseChooseATechnicalSkillFromTheSuggestions,
                    Colors.red,
                  );
                  return;
                }

                // 2) Prevent duplicates
                final alreadyAdded = viewModel.techSkills
                    .map((e) => e.skill?.toLowerCase())
                    .contains(skill);
                if (alreadyAdded) {
                  ToastDialog.show(
                    context.localization.technicalSkillIsAlreadyAdded(raw),
                    Colors.orange,
                  );
                  return;
                }

                // 3) All good—add it
                final displayLevel = viewModel.selectedProficiency;
                // must pick a level
                if (displayLevel == null) {
                  ToastDialog.show(
                    context.localization.pleaseSelectALevel,
                    Colors.red,
                  );
                  return;
                }
                final apiLevel = _displayToApi[displayLevel]!;
                print("apiLevel: '$apiLevel'");

                viewModel.addSkill(
                  skill: raw,
                  proficiency: apiLevel,
                  type: 'Technical',
                );
                viewModel.techSkillController.clear();
                setState(() {
                  viewModel.filteredSuggestions = [];
                  _showSuggestions = false;
                  viewModel.selectedProficiency = null;
                });
                ToastDialog.show(
                  '${context.localization.skillAddedSuccessfully} $raw',
                  Colors.green,
                );
              },
            ),
          ],
        ),
        if (_showSuggestions && viewModel.filteredSuggestions.isNotEmpty)
          SuggestionList(
            suggestions: viewModel.filteredSuggestions,
            onTap: (skill) {
              // fill the text field and hide
              viewModel.techSkillController.text = skill;
              setState(() {
                _showSuggestions = false;
              });
            },
          ),
      ],
    );
  }
}
