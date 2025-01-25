import 'package:flutter/material.dart';
import 'package:short_path/src/presentation/screens/widgets/infromation_gathering/profile/suggestion_list.dart';

import '../../../../mangers/infromation_gathering/profile/profile_viewmodel.dart';
import '../../../../shared_widgets/custom_auth_text_feild.dart';

class JobTitleInput extends StatelessWidget {
  const JobTitleInput({super.key, required this.viewModel});
  final ProfileViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          hintText: 'Enter your job title',
          keyboardType: TextInputType.text,
          controller: viewModel.jobTitleController,
          labelText: 'Job Title',
          validator: viewModel.validateJobTitle,
        ),
        if (viewModel.filteredJobSuggestions.isNotEmpty &&
            viewModel.jobTitleController.text.isNotEmpty)
          SuggestionList(
              suggestions: viewModel.filteredJobSuggestions,
              onTap: viewModel.selectJobTitle),
      ],
    );
  }
}
