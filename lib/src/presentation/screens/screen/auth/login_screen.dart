// login_screen.dart

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/dialogs/show_hide_loading.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/auth/login/login_states.dart';
import 'package:short_path/src/presentation/mangers/auth/login/login_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';

import '../../../mangers/auth/login/login_actions.dart';
import '../../widgets/auth/animated_form.dart';
import '../../widgets/auth/animated_logo.dart';
import '../../widgets/auth/no_account_row.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  // The LoginScreen now leverages AnimatedLogo and AnimatedForm.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A237E), // Deep Indigo Blue
              Color(0xFF283593), // Dark Baby Blue
              Color(0xFF1976D2), // Royal Blue Accent
              Color(0xFF64B5F6), // Soft Sky Blue
            ],
            stops: [0.1, 0.4, 0.7, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Position the animated logo at the top.
            Positioned(
              top: 70,
              left: 0,
              right: 0,
              child: Center(
                child: Hero(
                  tag: 'logo',
                  child: AnimatedLogo(width: 280.w, height: 280.h),
                ),
              ),
            ),
            // Position the animated form below the logo.
            Positioned.fill(
              top: 320,
              child: BlocProvider(
                create: (context) => getIt<LoginViewModel>(),
                child: BlocConsumer<LoginViewModel, LoginScreenState>(
                  buildWhen: (previous, current) =>
                      current is InitialState ||
                      current is ValidateColorButtonState,
                  listenWhen: (previous, current) => current is! InitialState,
                  listener: (context, state) {
                    if (state is LoadingState) {
                      showLoading(context, 'Logging in...');
                    } else if (state is ErrorState) {
                      hideLoading();
                      showAwesomeDialog(
                        context,
                        title: 'Error',
                        desc: state.exception,
                        onOk: () {},
                        dialogType: DialogType.error,
                      );
                    } else if (state is SuccessState) {
                      hideLoading();
                      Navigator.pushReplacementNamed(
                          context, RoutesName.project);
                    }
                  },
                  builder: (context, state) {
                    final viewModel = context.read<LoginViewModel>();
                    if (state is InitialState ||
                        state is ValidateColorButtonState) {
                      return SingleChildScrollView(
                        child: AnimatedForm(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.05),
                            child: Form(
                              key: viewModel.formKey,
                              onChanged: () => viewModel
                                  .doAction(ValidateColorButtonAction()),
                              child: Card(
                                elevation: 30,
                                shadowColor: Colors.black45,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.w, vertical: 36.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Welcome Back!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF102027),
                                            ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Text(
                                        'Log in to continue',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: const Color(0xFF546E7A),
                                            ),
                                      ),
                                      SizedBox(height: 30.h),
                                      CustomTextFormField(
                                        hintText: 'Enter your email',
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: viewModel.emailController,
                                        labelText: 'Email Address',
                                        validator: (val) =>
                                            null, // Replace with your validation logic
                                      ),
                                      SizedBox(height: 20.h),
                                      CustomTextFormField(
                                        isPasswordVisible:
                                            viewModel.isPasswordVisible,
                                        showPassword:
                                            viewModel.togglePasswordVisibility,
                                        hintText: 'Enter your password',
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        controller:
                                            viewModel.passwordController,
                                        labelText: 'Password',
                                        validator: (val) =>
                                            null, // Replace with your validation logic
                                      ),
                                      SizedBox(height: 5.h),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                              color: Color(0xFF546E7A),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        opacity: viewModel.validate ? 1.0 : 0.5,
                                        child: CustomAuthButton(
                                          text: 'SIGN IN',
                                          onPressed: viewModel.validate
                                              ? () => viewModel
                                                  .doAction(LoginAction())
                                              : null,
                                          color: viewModel.validate
                                              ? const Color(0xFF102027)
                                              : const Color(0xFFB0BC5),
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                      NoAccountRow(
                                        content: 'Don’t have an account?',
                                        actionText: 'Register here',
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                              context, RoutesName.register);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
