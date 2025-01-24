import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/src/presentation/mangers/infromation_gathering/profile/profile_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/infromation_gathering/profile/soft_skill_list_widget.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_drop_downButton_form_field.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../mangers/infromation_gathering/profile/profile_state.dart';
import '../../../../shared_widgets/custom_auth_button.dart';
import '../../../../shared_widgets/custom_auth_text_feild.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileViewmodel(),
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.only(top: 30.0), // Add space above the title
            child: const Text('Personal Details'),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
            child: BlocConsumer<ProfileViewmodel, ProfileState>(
              listener: (context, state) {
                if (state is ProfileUpdated) {
                  navKey.currentState?.pushNamed(RoutesName.skillGathering);
                }
              },
              builder: (context, state) {
                final viewModel = context.read<ProfileViewmodel>();

                return Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      Text(
                        'Create Your CV',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      verticalSpace(10),
                      Text(
                        'Fill in your details',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      verticalSpace(30),
                      CustomTextFormField(
                        hintText: 'Enter your job title',
                        keyboardType: TextInputType.text,
                        controller: viewModel.jobTitleController,
                        labelText: 'Job Title',
                        validator: viewModel.validateJobTitle,
                      ),
                      if (viewModel.filteredJobSuggestions.isNotEmpty &&
                          viewModel.jobTitleController.text.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.filteredJobSuggestions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                    viewModel.filteredJobSuggestions[index]),
                                onTap: () => viewModel.selectJobTitle(index),
                              );
                            },
                          ),
                        ),
                      verticalSpace(20),
                      CustomTextFormField(
                        hintText: 'Enter your GitHub profile URL',
                        keyboardType: TextInputType.name,
                        controller: viewModel.nameController,
                        labelText: 'GitHub Profile',
                        validator: viewModel.validateGitHubProfile,
                      ),
                      verticalSpace(20),
                      CustomTextFormField(
                        hintText: 'Enter your LinkedIn profile URL',
                        keyboardType: TextInputType.emailAddress,
                        controller: viewModel.emailController,
                        labelText: 'LinkedIn Profile',
                        validator: viewModel.validateLinkedInProfile,
                      ),
                      verticalSpace(20),
                      CustomTextFormField(
                        hintText: 'Enter your Profile Picture URL',
                        keyboardType: TextInputType.phone,
                        controller: viewModel.phoneController,
                        labelText: 'Profile Picture',
                        validator: viewModel.validateProfilePicture,
                      ),
                      verticalSpace(20),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CustomTextFormField(
                              hintText: 'Enter a language',
                              keyboardType: TextInputType.text,
                              controller: viewModel.languageController,
                              labelText: 'Language',
                              validator: (String? value) {
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: CustomDropdownButtonFormField(
                              labelText: 'Level',
                              items: viewModel.languageLevels
                                  .map((level) => DropdownMenuItem(
                                        child: Text(level),
                                        value: level,
                                      ))
                                  .toList(),
                              value: viewModel.selectedLanguageLevel,
                              onChanged: viewModel.selectLanguageLevel,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              if (viewModel
                                      .languageController.text.isNotEmpty &&
                                  viewModel.selectedLanguageLevel != null) {
                                viewModel.addLanguage(
                                  {
                                    'language':
                                        viewModel.languageController.text,
                                    'level': viewModel.selectedLanguageLevel!,
                                  },
                                );

                                // Reset language and level
                                viewModel.languageController.clear();
                                viewModel.selectLanguageLevel('Beginner');
                              }
                            },
                            color: AppColors.primaryColor,
                            splashRadius:
                                24, // Optional: Adjust splash radius for better UX
                          ),
                        ],
                      ),
                      if (viewModel.filteredLanguageSuggestions.isNotEmpty &&
                          viewModel.languageController.text.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                viewModel.filteredLanguageSuggestions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(viewModel
                                    .filteredLanguageSuggestions[index]),
                                onTap: () => viewModel.selectLanguage(index),
                              );
                            },
                          ),
                        ),
                      verticalSpace(20),
                      if (viewModel.languages.isNotEmpty)
                        const LanguageListWidget(),
                      verticalSpace(20),
                      CustomAuthButton(
                        text: 'NEXT',
                        onPressed: () {
                          viewModel.validateAndProceed();
                        },
                        color: viewModel.isFormValid
                            ? AppColors.primaryColor
                            : const Color(0xFF5C6673),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
