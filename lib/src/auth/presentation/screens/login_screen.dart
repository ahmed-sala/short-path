import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/widgets/custom_auth_button.dart';
import 'package:short_path/src/auth/presentation/viewmodels/login/login_viewmodel.dart';
import 'package:short_path/src/auth/presentation/widgets/no_account_row.dart';

import '../../../../config/helpers/validations.dart';
import '../../../../config/routes/routes_name.dart';
import '../../../../core/widgets/custom_auth_text_feild.dart';
import '../../../../dependency_injection/di.dart';
import '../../../../main.dart';
import '../viewmodels/login/login_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel loginViewModel = getIt<LoginViewModel>();
  bool passwordVisible = true;
  bool validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: BlocProvider(
                create: (context) => loginViewModel,
                child: BlocConsumer<LoginViewModel, LoginScreenState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is InitialState ||
                        state is ValidateColorButtonState) {
                      return Form(
                        key: loginViewModel.formKey,
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 32),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Logo or Icon
                                const Icon(Icons.lock_outline,
                                    size: 80, color: AppColors.primaryColor),
                                const SizedBox(height: 20),
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
                                const SizedBox(height: 12),
                                Text(
                                  'Log in to your account',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: Colors.grey[600]),
                                ),
                                const SizedBox(height: 30),
                                CustomTextFormField(
                                  hintText: 'Enter your email',
                                  keyboardType: TextInputType.emailAddress,
                                  controller: loginViewModel.emailController,
                                  labelText: 'Email Address',
                                  validator: (val) {
                                    return Validations.validateEmail(val);
                                  },
                                ),
                                const SizedBox(height: 20),
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
                                  validator: (val) {
                                    return Validations.validatePassword(val);
                                  },
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text('Forgot Password?'),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                CustomAuthButton(
                                  text: 'SIGN IN',
                                  onPressed: () {},
                                  color: loginViewModel.validate
                                      ? AppColors.primaryColor
                                      : Colors.grey,
                                ),
                                const SizedBox(height: 20),
                                NoAccountRow(
                                  content: 'Don’t Have an Account?',
                                  actionText: 'Register Here',
                                  onPressed: () {
                                    navKey.currentState!.pushReplacementNamed(
                                        RoutesName.register);
                                  },
                                ),
                              ],
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
          ),
        ],
      ),
    );
  }
}
