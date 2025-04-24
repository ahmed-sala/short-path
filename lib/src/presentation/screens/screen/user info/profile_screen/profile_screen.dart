import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/dialogs/show_hide_loading.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/user_info/profile/profile_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/profile/profile_viewmodel.dart';
import 'package:short_path/src/presentation/mangers/user_info/Language/language_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/Language/language_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/profile/header_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/profile/job_title_input.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/profile/portfolio_input.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/profile/portfolio_list_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/profile/language_input.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/profile/language_list_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/profile/suggestion_list.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';
import 'package:short_path/src/presentation/shared_widgets/progress_bar.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../../../config/helpers/validations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileVM = getIt.get<ProfileViewmodel>();
    final languageVM = getIt.get<LanguageViewmodel>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileViewmodel>(create: (_) => profileVM),
        BlocProvider<LanguageViewmodel>(create: (_) => languageVM),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: BlocConsumer<ProfileViewmodel, ProfileState>(
              listener: (context, state) {
                if (state is ProfileLoading) {
                  showLoading(context, 'Adding profile...');
                }
                if (state is ProfileUpdateSuccess) {
                  navKey.currentState!.pushNamedAndRemoveUntil(
                      RoutesName.skillGathering, (route) => false);
                }
                if (state is ProfileUpdateError) {
                  showAwesomeDialog(
                    context,
                    title: 'Error',
                    desc: state.message,
                    onOk: () {},
                    dialogType: DialogType.error,
                  );
                }
              },
              buildWhen: (previous, current) =>
              current is ProfileInitialState ||
                  current is ValidateColorButtonState,
              listenWhen: (previous, current) {
                if (previous is ProfileLoading ||
                    current is ProfileUpdateError) hideLoading();
                return current is! ProfileInitialState;
              },
              builder: (context, state) {
                final profVM = context.read<ProfileViewmodel>();
                final langVM = context.read<LanguageViewmodel>();

                return Form(
                  key: profVM.formKey,
                  onChanged: profVM.validateColorButton,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(40),
                      const Center(child: HeaderWidget()),
                      StepProgressBar(currentStep: 1),
                      verticalSpace(22),
                      JobTitleInput(viewModel: profVM),
                      verticalSpace(20),
                      PortfolioInput(viewModel: profVM),
                      if (profVM.portfolioLinks.isNotEmpty)
                        const PortfolioListWidget(),
                      verticalSpace(20),
                      CustomTextFormField(
                        hintText: 'Enter your LinkedIn profile URL',
                        keyboardType: TextInputType.url,
                        controller: profVM.linkedInController,
                        labelText: 'LinkedIn Profile',
                        validator: (value) => validateLink(value),
                      ),
                      verticalSpace(20),
                      CustomTextFormField(
                        hintText: 'Enter your Profile Picture URL',
                        keyboardType: TextInputType.url,
                        controller: profVM.profilePictureController,
                        labelText: 'Profile Picture',
                        validator: (value) => validateLink(value),
                      ),
                      verticalSpace(20),
                      LanguageInput(viewModel: langVM),
                      verticalSpace(20),
                      CustomTextFormField(
                        hintText: 'Enter your Bio',
                        keyboardType: TextInputType.text,
                        controller: profVM.bioController,
                        labelText: 'Summary',
                        validator: (value) => validateSummary(value),
                      ),
                      if (langVM.filteredLanguageSuggestions.isNotEmpty &&
                          langVM.languageController.text.isNotEmpty)
                        SuggestionList(
                          suggestions: langVM.filteredLanguageSuggestions,
                          onTap: langVM.selectLanguage,
                        ),
                      if (langVM.languages.isNotEmpty)
                        const LanguageListWidget(),

                      verticalSpace(15),
                      CustomAuthButton(
                        text: 'NEXT',
                        onPressed: () {
                          // First submit profile, then languages
                          profVM.next();
                          langVM.next();
                        },
                        color: profVM.validate
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
