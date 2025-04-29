import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/data/static_data/demo_data_list.dart';
import 'package:short_path/src/presentation/mangers/user_info/skill_gathering/skill_gathering_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';

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
                validator: (value) {
                  return null;
                },
                onChanged: (value) {
                  final filteredSkills = softSkills
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
            // Add Skill Icon Button
            IconButton(
              icon: const Icon(Icons.add_circle,
                  color: AppColors.primaryColor, size: 30),
              onPressed: () {
                Fluttertoast.cancel();
                final skill = viewModel.softSkillController.text.trim();
                if (skill.isNotEmpty) {
                  viewModel.addSkill(
                    type: 'Soft',
                    skill: skill,
                  );
                  softSkills.remove(skill);
                  viewModel.softSkillController.clear();
                  setState(() {
                    viewModel.filteredSuggestions = [];
                    _showSuggestions = false;
                  });
                  ToastDialog.show(
                      '${context.localization.skill} $skill ${context.localization.skillAddedSuccessfully}',
                      Colors.green);
                }
              },
            ),
          ],
        ),
        if (_showSuggestions && viewModel.filteredSuggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: const BoxConstraints(maxHeight: 150),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: viewModel.filteredSuggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(viewModel.filteredSuggestions[index]),
                  onTap: () {
                    viewModel.softSkillController.text =
                        viewModel.filteredSuggestions[index];
                    setState(() {
                      _showSuggestions = false;
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
