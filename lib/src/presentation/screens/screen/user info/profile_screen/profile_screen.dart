import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/data/static_data/demo_data_list.dart';
import 'package:short_path/src/presentation/mangers/infromation_gathering/profile/profile_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/infromation_gathering/profile/header_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/infromation_gathering/profile/job_title_input.dart';
import 'package:short_path/src/presentation/screens/widgets/infromation_gathering/profile/language_input.dart';
import 'package:short_path/src/presentation/screens/widgets/infromation_gathering/profile/language_list_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/infromation_gathering/profile/portfolio_input.dart';
import 'package:short_path/src/presentation/screens/widgets/infromation_gathering/profile/portfolio_list_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/infromation_gathering/profile/suggestion_list.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../mangers/infromation_gathering/profile/profile_state.dart';
import '../../../../shared_widgets/custom_auth_button.dart';
import '../../../../shared_widgets/custom_auth_text_feild.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileViewmodel viewModel = getIt.get<ProfileViewmodel>();
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Personal Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: BlocConsumer<ProfileViewmodel, ProfileState>(
              listener: (context, state) {
                if (state is ProfileUpdated) {
                  navKey.currentState?.pushNamed(RoutesName.skillGathering);
                }
              },
              buildWhen: (previous, current) {
                return current is ProfileInitialState ||
                    current is ValidateColorButtonState;
              },
              builder: (context, state) {
                final viewModel = context.read<ProfileViewmodel>();

                if (state is ValidateColorButtonState ||
                    state is ProfileInitialState) {
                  return Form(
                    key: viewModel.formKey,
                    onChanged: viewModel.validateColorButton,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: HeaderWidget()),
                        verticalSpace(30),
                        JobTitleInput(viewModel: viewModel),
                        verticalSpace(20),
                        PortfolioInput(viewModel: viewModel),
                        if (viewModel.portfolioLinks.isNotEmpty)
                          const PortfolioListWidget(),
                        verticalSpace(20),
                        CustomTextFormField(
                          hintText: 'Enter your LinkedIn profile URL',
                          keyboardType: TextInputType.url,
                          controller: viewModel.linkedInController,
                          labelText: 'LinkedIn Profile',
                          validator: viewModel.validateLinkedInProfile,
                        ),
                        verticalSpace(20),
                        CustomTextFormField(
                          hintText: 'Enter your Profile Picture URL',
                          keyboardType: TextInputType.url,
                          controller: viewModel.profilePictureController,
                          labelText: 'Profile Picture',
                          validator: viewModel.validateProfilePicture,
                        ),
                        verticalSpace(20),
                        CustomTextFormField(
                          hintText: 'Enter your Bio',
                          keyboardType: TextInputType.url,
                          controller: viewModel.bioController,
                          labelText: 'Summary',
                          validator: viewModel.validateProfilePicture,
                        ),
                        verticalSpace(20),
                        LanguageInput(viewModel: viewModel),
                        verticalSpace(20),
                        if (viewModel.filteredLanguageSuggestions.isNotEmpty &&
                            viewModel.languageController.text.isNotEmpty)
                          SuggestionList(
                            suggestions: languageSuggestions,
                            onTap: (int index) {
                              viewModel.selectLanguage(index);
                            },
                          ),
                        if (viewModel.languages.isNotEmpty)
                          const LanguageListWidget(),
                        verticalSpace(30),
                        CustomAuthButton(
                          text: 'NEXT',
                          onPressed: viewModel.next,
                          color: viewModel.validate
                              ? AppColors.primaryColor
                              : const Color(0xFF5C6673),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
