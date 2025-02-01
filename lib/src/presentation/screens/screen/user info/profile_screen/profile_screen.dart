import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/data/static_data/demo_data_list.dart';
import 'package:short_path/src/presentation/mangers/user_info/Language/language_viewmodel.dart';

import '../../../../../../core/dialogs/awesome_dialoge.dart';
import '../../../../../../core/dialogs/show_hide_loading.dart';
import '../../../../../short_path.dart';
import '../../../../mangers/user_info/profile/profile_state.dart';
import '../../../../mangers/user_info/profile/profile_viewmodel.dart';
import '../../../../shared_widgets/custom_auth_button.dart';
import '../../../../shared_widgets/custom_auth_text_feild.dart';
import '../../../widgets/user info/profile/header_widget.dart';
import '../../../widgets/user info/profile/job_title_input.dart';
import '../../../widgets/user info/profile/language_input.dart';
import '../../../widgets/user info/profile/language_list_widget.dart';
import '../../../widgets/user info/profile/portfolio_input.dart';
import '../../../widgets/user info/profile/portfolio_list_widget.dart';
import '../../../widgets/user info/profile/suggestion_list.dart';

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
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: BlocConsumer<ProfileViewmodel, ProfileState>(
              listener: (context, state) {
                switch (state) {
                  case ProfileLoading():
                    showLoading(context, 'Adding profile...');
                  case ProfileUpdateSuccess():
                    navKey.currentState!
                        .pushReplacementNamed(RoutesName.skillGathering);
                  case ProfileUpdateError():
                    showAwesomeDialog(context,
                        title: 'error',
                        desc: state.message,
                        onOk: () {},
                        dialogType: DialogType.error);
                  default:
                }
              },
              buildWhen: (previous, current) {
                return current is ProfileInitialState ||
                    current is ValidateColorButtonState;
              },
              listenWhen: (previous, current) {
                if (previous is ProfileLoading ||
                    current is ProfileUpdateError) {
                  hideLoading();
                }
                return current is! ProfileInitialState;
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
                        // LanguageInput(viewModel: viewModel),
                        // verticalSpace(20),
                        // if (viewModel.filteredLanguageSuggestions.isNotEmpty &&
                        //     viewModel.languageController.text.isNotEmpty)
                        //   SuggestionList(
                        //     suggestions: languageSuggestions,
                        //     onTap: (int index) {
                        //       viewModel.selectLanguage(index);
                        //     },
                        //   ),
                        // if (viewModel.languages.isNotEmpty)
                        //   const LanguageListWidget(),
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
