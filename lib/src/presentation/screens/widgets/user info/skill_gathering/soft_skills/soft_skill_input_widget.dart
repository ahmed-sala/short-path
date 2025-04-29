import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/data/static_data/demo_data_list.dart';
import 'package:short_path/src/presentation/mangers/user_info/skill_gathering/skill_gathering_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';

import '../../../../../shared_widgets/suggetion_list.dart';
import '../../../../../shared_widgets/toast_dialoge.dart';

class SoftSkillInputWidget extends StatefulWidget {
  const SoftSkillInputWidget({super.key});

  @override
  _SoftSkillInputWidgetState createState() => _SoftSkillInputWidgetState();
}

class _SoftSkillInputWidgetState extends State<SoftSkillInputWidget> {
  bool _showSuggestions = false;

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
              flex: 3,
              child: CustomTextFormField(
                labelText: context.localization.skill,
                hintText: context.localization.enterYourSkill,
                keyboardType: TextInputType.text,
                controller: viewModel.softSkillController,
                validator: (_) => null,
                onChanged: (value) {
                  final input = value.toLowerCase();
                  final filtered = softSkills.where((skill) {
                    final lower = skill.toLowerCase();
                    // match prefix and not already added
                    return lower.contains(input) &&
                        !viewModel.softSkills
                            .map((s) => s.toLowerCase())
                            .contains(lower);
                  }).toList();

                  setState(() {
                    viewModel.filteredSuggestions = filtered;
                    _showSuggestions = value.isNotEmpty && filtered.isNotEmpty;
                  });
                },
              ),
            ),

            const SizedBox(width: 8),
            // Add Skill Icon Button
            IconButton(
              icon: const Icon(Icons.add_circle,
                  color: AppColors.primaryColor, size: 30),
              onPressed: () {
                Fluttertoast.cancel();
                final raw = viewModel.softSkillController.text.trim();
                final lower = raw.toLowerCase();

                // 1) Must exist in master list
                if (!softSkills.map((s) => s.toLowerCase()).contains(lower)) {
                  ToastDialog.show(
                    'Please choose a soft skill from the suggestions',
                    Colors.red,
                  );
                  return;
                }

                // 2) Prevent duplicates
                if (viewModel.softSkills
                    .map((s) => s.toLowerCase())
                    .contains(lower)) {
                  ToastDialog.show(
                    'Soft skill "$raw" is already added',
                    Colors.orange,
                  );
                  return;
                }

                // 3) All good → add and remove from master list
                viewModel.addSkill(type: 'Soft', skill: raw);
                softSkills.removeWhere(
                    (s) => s.toLowerCase() == lower); // keep master clean

                viewModel.softSkillController.clear();
                setState(() {
                  viewModel.filteredSuggestions = [];
                  _showSuggestions = false;
                });
                ToastDialog.show(
                  '${context.localization.skill} "$raw" ${context.localization.skillAddedSuccessfully}',
                  Colors.green,
                );
              },
            ),
          ],
        ),

        // SuggestionList dropdown
        if (_showSuggestions)
          SuggestionList(
            suggestions: viewModel.filteredSuggestions,
            onTap: (selection) {
              viewModel.softSkillController.text = selection;
              setState(() {
                _showSuggestions = false;
              });
            },
          ),
      ],
    );
  }
}
