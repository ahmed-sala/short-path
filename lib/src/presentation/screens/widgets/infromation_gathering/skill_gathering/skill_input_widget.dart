import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/styles/colors/app_colore.dart';
import '../../../../../domain/entities/infromation_gathering/skill_entity.dart';
import '../../../../mangers/infromation_gathering/skill_gathering/skill_gathering_viewmodel.dart';
import '../../../../shared_widgets/custom_auth_text_feild.dart';
import '../../../../shared_widgets/custom_drop_downButton_form_field.dart';

class SkillInputWidget extends StatefulWidget {
  SkillInputWidget({super.key});

  @override
  _SkillInputSectionState createState() => _SkillInputSectionState();
}

class _SkillInputSectionState extends State<SkillInputWidget> {
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
                labelText: 'Skill',
                hintText: 'Enter your skill',
                keyboardType: TextInputType.text,
                controller: viewModel.skillController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a skill';
                  }
                  return null;
                },
                onChanged: (value) {
                  final filteredSkills = viewModel.technicalSkills
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
              flex: 2,
              child: CustomDropdownButtonFormField<String>(
                labelText: 'Proficiency',
                hintText: 'Select proficiency',
                value: viewModel.selectedProficiency,
                onChanged: (String? newValue) {
                  setState(() {
                    viewModel.selectedProficiency = newValue!;
                  });
                },
                items: ['Beginner', 'Moderate', 'Advanced']
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
                final skill = viewModel.skillController.text.trim();
                if (skill.isNotEmpty) {
                  viewModel.addSkill(
                    SkillEntity(
                        skill: skill,
                        proficiency: viewModel.selectedProficiency),
                  );
                  viewModel.skillController.clear();
                  setState(() {
                    viewModel.filteredSuggestions = [];
                    _showSuggestions = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Skill added successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
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
                    viewModel.skillController.text =
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
