import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/auth/register/register_states.dart';
import 'package:short_path/src/presentation/mangers/auth/register/register_viewmodel.dart';
import 'package:short_path/src/presentation/screens/screen/auth/widgets/animated_logo.dart';
import 'package:short_path/src/presentation/screens/screen/auth/widgets/first_step_register.dart';
import 'package:short_path/src/presentation/screens/screen/auth/widgets/no_account_row.dart';
import 'package:short_path/src/presentation/screens/screen/auth/widgets/second_step_register.dart';

import 'widgets/animated_form.dart';
import 'widgets/custom_progress_bar.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterViewModel>(
      create: (_) => getIt<RegisterViewModel>(),
      child: BlocConsumer<RegisterViewModel, RegisterScreenState>(
        listener: (context, state) {
          if (state is LoadingState) {
            EasyLoading.show(
              status: context.localization.registering,
            );
          } else if (state is ErrorState) {
            EasyLoading.dismiss();
            EasyLoading.showError(
              state.exception ?? context.localization.errorOccurred,
            );
          } else if (state is SuccessState) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess(
                context.localization.registrationSuccessful);

            Navigator.pushReplacementNamed(context, RoutesName.postRegisterChoice);
          }
        },
        builder: (context, state) {
          final viewModel = context.read<RegisterViewModel>();
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A237E),
                  Color(0xFF283593),
                  Color(0xFF1976D2),
                  Color(0xFF64B5F6),
                ],
                stops: [0.1, 0.4, 0.7, 1.0],
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: Column(
                  children: [
                    // Animated logo at the top
                    const AnimatedLogo(width: 280, height: 280),
                    // Wrap your form in the AnimatedForm widget
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: AnimatedForm(
                        child: Form(
                          key: viewModel.formKey,
                          onChanged: () => viewModel.validateColorButton(),
                          child: Card(
                            elevation: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    context.localization.createAnAccount,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF102027),
                                        ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Progress Bar is added here
                                  const CustomProgressBar(),
                                  const SizedBox(height: 10),
                                  viewModel.currentStep == 0
                                      ? const FirstStepRegister()
                                      : const SecondStepRegister(),
                                  const SizedBox(height: 20),
                                  NoAccountRow(
                                    content: context
                                        .localization.alreadyHaveAnAccount,
                                    actionText: context.localization.logInHere,
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, RoutesName.login);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
