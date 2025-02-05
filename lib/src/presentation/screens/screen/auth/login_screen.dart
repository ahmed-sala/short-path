import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/images/app_images.dart';

import '../../../../../../config/helpers/validations.dart';
import '../../../../../../config/routes/routes_name.dart';
import '../../../../../../core/dialogs/show_hide_loading.dart';
import '../../../../../../dependency_injection/di.dart';
import '../../../../../core/styles/spacing.dart';
import '../../../../short_path.dart';
import '../../../mangers/auth/login/login_actions.dart';
import '../../../mangers/auth/login/login_states.dart';
import '../../../mangers/auth/login/login_viewmodel.dart';
import '../../../shared_widgets/custom_auth_button.dart';
import '../../../shared_widgets/custom_auth_text_feild.dart';
import '../../widgets/auth/no_account_row.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel loginViewModel = getIt<LoginViewModel>();
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
          ),
          // Positioned logo
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  AppImages.logo,
                  width: 250.w,
                  height: 250.h,
                ),
              ),
            ),
          ),

          // Login Form
          BlocProvider(
            create: (context) => loginViewModel,
            child: BlocConsumer<LoginViewModel, LoginScreenState>(
              buildWhen: (previous, current) {
                return current is InitialState ||
                    current is ValidateColorButtonState;
              },
              listenWhen: (previous, current) {
                if (previous is LoadingState || current is ErrorState) {
                  hideLoading();
                }
                return current is! InitialState;
              },
              listener: (context, state) {
                switch (state) {
                  case LoadingState():
                    showLoading(context, 'Logging in...');
                  case ErrorState():
                    showAwesomeDialog(context,
                        title: 'error',
                        desc: state.exception,
                        onOk: () {},
                        dialogType: DialogType.error);
                  case SuccessState():
                    navKey.currentState!
                        .pushReplacementNamed(RoutesName.education);
                  default:
                }
              },
              builder: (context, state) {
                if (state is InitialState ||
                    state is ValidateColorButtonState) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.4),
                      child: Form(
                        key: loginViewModel.formKey,
                        onChanged: () => loginViewModel
                            .doAction(ValidateColorButtonAction()),
                        child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.w, vertical: 40.h),
                            child: Column(
                              children: [
                                Text(
                                  'Welcome Back!',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                verticalSpace(10),
                                Text(
                                  'Log in to continue',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                ),
                                verticalSpace(30),
                                CustomTextFormField(
                                  hintText: 'Enter your email',
                                  keyboardType: TextInputType.emailAddress,
                                  controller: loginViewModel.emailController,
                                  labelText: 'Email Address',
                                  validator: (val) =>
                                      Validations.validateEmail(val),
                                ),
                                verticalSpace(20),
                                CustomTextFormField(
                                  isPasswordVisible: passwordVisible,
                                  showPassword: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                  hintText: 'Enter your password',
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: loginViewModel.passwordController,
                                  labelText: 'Password',
                                  validator: (val) =>
                                      Validations.validatePassword(val),
                                ),
                                verticalSpace(10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {}, // Add navigation
                                    child: const Text('Forgot Password?'),
                                  ),
                                ),
                                verticalSpace(20),
                                CustomAuthButton(
                                  text: 'SIGN IN',
                                  onPressed: loginViewModel.validate
                                      ? () =>
                                          loginViewModel.doAction(LoginAction())
                                      : null,
                                  color: loginViewModel.validate
                                      ? AppColors.primaryColor
                                      : const Color(0xFF5C6673),
                                ),
                                const SizedBox(height: 20),
                                NoAccountRow(
                                  content: 'Don’t have an account?',
                                  actionText: 'Register here',
                                  onPressed: () {
                                    navKey.currentState!.pushReplacementNamed(
                                        RoutesName.register);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
