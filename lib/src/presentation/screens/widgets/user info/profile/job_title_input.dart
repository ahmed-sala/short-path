import 'package:flutter/material.dart';
import 'package:short_path/config/helpers/validations.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/src/presentation/mangers/user_info/profile/profile_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';

import '../../../../shared_widgets/suggetion_list.dart';

class JobTitleInput extends StatelessWidget {
  const JobTitleInput({super.key, required this.viewModel});

  final ProfileViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          hintText: context.localization.enterYourJobTitle,
          keyboardType: TextInputType.text,
          controller: viewModel.jobTitleController,
          labelText: context.localization.jobTitle,
          validator: (value) {
            return validateJobTitle(value);
          },
        ),
        if (viewModel.filteredJobSuggestions.isNotEmpty &&
            viewModel.jobTitleController.text.isNotEmpty)
          SuggestionList(
            suggestions: viewModel.filteredJobSuggestions,
            onTap: (selected) {
              final index = viewModel.filteredJobSuggestions.indexOf(selected);
              viewModel.selectJobTitle(index);
            },
          ),
      ],
    );
  }
}
