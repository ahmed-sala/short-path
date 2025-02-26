import 'package:flutter/material.dart';
import 'package:short_path/config/helpers/validations.dart';
import 'package:short_path/src/presentation/mangers/user_info/profile/profile_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/profile/suggestion_list.dart';

class JobTitleInput extends StatelessWidget {
  const JobTitleInput({super.key, required this.viewModel});
  final ProfileViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: TextFormField(
            controller: viewModel.jobTitleController,
            keyboardType: TextInputType.text,
            validator: (value) => validateJobTitle(value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.work_outline_rounded, color: Colors.blueAccent),
              labelText: 'Job Title',
              labelStyle: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1,
              ),
              hintText: 'Enter your job title',
              hintStyle: TextStyle(color: Colors.grey[400]),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (viewModel.filteredJobSuggestions.isNotEmpty &&
            viewModel.jobTitleController.text.isNotEmpty)
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SuggestionList(
              suggestions: viewModel.filteredJobSuggestions,
              onTap: viewModel.selectJobTitle,
            ),
          ),
      ],
    );
  }
}
