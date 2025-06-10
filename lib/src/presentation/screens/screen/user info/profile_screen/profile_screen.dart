import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/dialogs/show_hide_loading.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/user_info/Language/language_viewmodel.dart';
import 'package:short_path/src/presentation/mangers/user_info/profile/profile_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/profile/profile_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/profile/header_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/profile/job_title_input.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/profile/language_input.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/profile/language_list_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/profile/portfolio_input.dart';
import 'package:short_path/src/presentation/screens/widgets/user info/profile/portfolio_list_widget.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';
import 'package:short_path/src/presentation/shared_widgets/progress_bar.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../../../config/helpers/validations.dart';
import '../../../../mangers/user_info/Language/language_state.dart';

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
                  showLoading(context, context.localization.addingProfile);
                }
                if (state is ProfileUpdateSuccess) {
                  navKey.currentState!.pushNamedAndRemoveUntil(
                      RoutesName.skillGathering, (r) => false);
                }
                if (state is ProfileUpdateError) {
                  showAwesomeDialog(
                    context,
                    title: context.localization.error,
                    desc: state.message,
                    onOk: () {},
                    dialogType: DialogType.error,
                  );
                }
              },
              buildWhen: (prev, cur) =>
                  cur is ProfileInitialState || cur is ValidateColorButtonState,
              listenWhen: (prev, cur) {
                if (prev is ProfileLoading || cur is ProfileUpdateError)
                  hideLoading();
                return cur is! ProfileInitialState;
              },
              builder: (context, state) {
                final profVM = context.read<ProfileViewmodel>();

                return Form(
                  key: profVM.formKey,
                  onChanged: profVM.validateColorButton,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(40),
                      const Center(child: HeaderWidget()),
                      StepProgressBar(
                        currentStep: 1,
                        stepNames: [
                          context.localization.personalInfo,
                          context.localization.skills,
                          context.localization.education,
                          context.localization.experience,
                          context.localization.projects,
                          context.localization.certifications,
                          context.localization.additionalInfo,
                        ],
                      ),
                      verticalSpace(22),

                      // Job title & portfolio
                      JobTitleInput(viewModel: profVM),
                      verticalSpace(20),
                      PortfolioInput(viewModel: profVM),
                      if (profVM.portfolioLinks.isNotEmpty)
                        const PortfolioListWidget(),
                      verticalSpace(20),

                      // LinkedIn & Picture URLs
                      CustomTextFormField(
                        hintText:
                            context.localization.enterYourLinkedInProfileUrl,
                        keyboardType: TextInputType.url,
                        controller: profVM.linkedInController,
                        labelText: context.localization.linkedInProfile,
                        validator: validateLink,
                      ),
                      verticalSpace(20),
                      CustomTextFormField(
                        hintText:
                            context.localization.enterYourProfilePictureUrl,
                        keyboardType: TextInputType.url,
                        controller: profVM.profilePictureController,
                        labelText: context.localization.profilePicture,
                        validator: validateLink,
                      ),
                      verticalSpace(20),

                      // LANGUAGE INPUT + suggestions & selected list
                      LanguageInput(
                          viewModel: context.read<LanguageViewmodel>()),
                      verticalSpace(8),

                      BlocBuilder<LanguageViewmodel, LanguageState>(
                        builder: (context, langState) {
                          final langVM = context.read<LanguageViewmodel>();
                          if (langVM.languages.isNotEmpty) {
                            return const LanguageListWidget();
                          }

                          return const SizedBox.shrink();
                        },
                      ),

                      verticalSpace(20),

                      // Bio / Summary
                      CustomTextFormField(
                        hintText: context.localization.enterYourBioSummary,
                        keyboardType: TextInputType.text,
                        controller: profVM.bioController,
                        labelText: context.localization.bioSummary,
                        validator: validateSummary,
                      ),
                      verticalSpace(15),

                      // NEXT button
                      CustomAuthButton(
                        text: context.localization.next,
                        onPressed: () {
                          profVM.next();
                          context.read<LanguageViewmodel>().next();
                        },
                        color: profVM.validate
                            ? AppColors.primaryColor
                            : const Color(0xFF5C6673),
                      ),
                      verticalSpace(30),
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
