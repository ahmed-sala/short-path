import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/widgets/custom_auth_button.dart';
import 'package:short_path/main.dart';
import 'package:short_path/src/auth/presentation/widgets/no_account_row.dart';

import '../../../../config/helpers/validations.dart';
import '../../../../core/widgets/custom_auth_text_feild.dart';
import '../../../../dependency_injection/di.dart';
import '../viewmodels/register/register_states.dart';
import '../viewmodels/register/register_viewmodel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterViewModel registerViewModel = getIt<RegisterViewModel>();
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  bool validate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
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
                create: (context) => registerViewModel,
                child: BlocConsumer<RegisterViewModel, RegisterScreenState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Form(
                      key: registerViewModel.formKey,
                      onChanged: () {
                        if (registerViewModel.fullNameController.text.isEmpty ||
                            registerViewModel.emailController.text.isEmpty ||
                            registerViewModel.phoneController.text.isEmpty ||
                            registerViewModel.passwordController.text.isEmpty ||
                            registerViewModel
                                .rePasswordController.text.isEmpty) {
                          validate = false;
                        } else if (!registerViewModel.formKey.currentState!
                            .validate()) {
                          validate = false;
                        } else {
                          validate = true;
                        }
                      },
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
                              Icon(Icons.person_add_alt_1_outlined,
                                  size: 80, color: AppColors.primaryColor),
                              const SizedBox(height: 20),
                              Text(
                                'Create an Account',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Join us and enjoy exclusive benefits.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 30),
                              // Full Name Field
                              CustomTextFormField(
                                hintText: 'Enter your full name',
                                controller:
                                    registerViewModel.fullNameController,
                                labelText: 'Full Name',
                                validator: (val) {
                                  return Validations.validateName(context, val);
                                },
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 20),
                              // Email Field
                              CustomTextFormField(
                                hintText: 'Enter your email',
                                keyboardType: TextInputType.emailAddress,
                                controller: registerViewModel.emailController,
                                labelText: 'Email Address',
                                validator: (val) {
                                  return Validations.validateEmail(
                                      context, val);
                                },
                              ),
                              const SizedBox(height: 20),
                              // Phone Number Field
                              CustomTextFormField(
                                hintText: 'Enter your phone number',
                                keyboardType: TextInputType.phone,
                                controller: registerViewModel.phoneController,
                                labelText: 'Phone Number',
                                validator: (val) {
                                  if (val!.length < 10 && val.isNotEmpty) {
                                    {
                                      return 'Phone number must be at least 10 characters';
                                    }
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              // Password Field
                              CustomTextFormField(
                                isPasswordVisible: passwordVisible,
                                showPassword: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                                hintText: 'Enter your password',
                                keyboardType: TextInputType.visiblePassword,
                                controller:
                                    registerViewModel.passwordController,
                                labelText: 'Password',
                                validator: (val) {
                                  return Validations.validatePassword(
                                      context, val);
                                },
                              ),
                              const SizedBox(height: 20),
                              // Confirm Password Field
                              CustomTextFormField(
                                isPasswordVisible: confirmPasswordVisible,
                                showPassword: () {
                                  setState(() {
                                    confirmPasswordVisible =
                                        !confirmPasswordVisible;
                                  });
                                },
                                hintText: 'Confirm your password',
                                keyboardType: TextInputType.visiblePassword,
                                controller:
                                    registerViewModel.rePasswordController,
                                labelText: 'Confirm Password',
                                validator: (val) {
                                  return Validations.validateConfirmPassword(
                                      context,
                                      val,
                                      registerViewModel
                                          .passwordController.text);
                                },
                              ),
                              const SizedBox(height: 30),
                              CustomAuthButton(
                                text: 'REGISTER',
                                onPressed: () {},
                                color: validate
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                              ),
                              const SizedBox(height: 20),
                              NoAccountRow(
                                  content: 'Already have an account?',
                                  actionText: 'Sign In Here',
                                  onPressed: () {
                                    navKey.currentState!
                                        .pushReplacementNamed(RoutesName.login);
                                  })
                            ],
                          ),
                        ),
                      ),
                    );
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
