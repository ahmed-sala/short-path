import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/helpers/validations.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/dialogs/show_hide_loading.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/user_info/profile/profile_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/profile/profile_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/profile/header_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/profile/job_title_input.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/profile/portfolio_input.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/profile/portfolio_list_widget.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../shared_widgets/progress_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileViewmodel viewModel = getIt.get<ProfileViewmodel>();

    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: BlocConsumer<ProfileViewmodel, ProfileState>(
              listener: (context, state) {
                if (state is ProfileLoading) {
                  showLoading(context, 'Adding profile...');
                } else if (state is ProfileUpdateSuccess) {
                  navKey.currentState!.pushNamedAndRemoveUntil(
                      RoutesName.language, (route) => false);
                } else if (state is ProfileUpdateError) {
                  showAwesomeDialog(context,
                      title: 'Error',
                      desc: state.message,
                      onOk: () {},
                      dialogType: DialogType.error);
                }
              },
              buildWhen: (previous, current) =>
              current is ProfileInitialState || current is ValidateColorButtonState,
              listenWhen: (previous, current) {
                if (previous is ProfileLoading || current is ProfileUpdateError) {
                  hideLoading();
                }
                return current is! ProfileInitialState;
              },
              builder: (context, state) {
                final viewModel = context.read<ProfileViewmodel>();

                if (state is ValidateColorButtonState || state is ProfileInitialState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(40),
                      Center(child: HeaderWidget()),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: StepProgressBar(currentStep: 1), // Pass only current step
                        ),
                      ),
                      verticalSpace(30),
                      Form(
                        key: viewModel.formKey,
                        onChanged: viewModel.validateColorButton,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              validator: validateLink,
                            ),
                            verticalSpace(20),
                            CustomTextFormField(
                              hintText: 'Enter your Profile Picture URL',
                              keyboardType: TextInputType.url,
                              controller: viewModel.profilePictureController,
                              labelText: 'Profile Picture',
                              validator: validateLink,
                            ),
                            verticalSpace(20),
                            CustomTextFormField(
                              hintText: 'Enter your Bio',
                              keyboardType: TextInputType.text,
                              controller: viewModel.bioController,
                              labelText: 'Summary',
                              validator: validateSummary,
                            ),
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
                      ),
                    ],
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
