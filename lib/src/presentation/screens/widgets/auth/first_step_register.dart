import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/extensions/extensions.dart';

import '../../../mangers/auth/register/register_viewmodel.dart';
import '../../../shared_widgets/custom_auth_button.dart';
import '../../../shared_widgets/custom_auth_text_feild.dart';

class FirstStepRegister extends StatelessWidget {
  const FirstStepRegister({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<RegisterViewModel>();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                hintText: context.localization.firstName,
                controller: viewModel.firstNameController,
                labelText: context.localization.firstName,
                validator: (val) => viewModel.validateName(val),
                keyboardType: TextInputType.name,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: CustomTextFormField(
                hintText: context.localization.lastName,
                controller: viewModel.lastNameController,
                labelText: context.localization.lastName,
                validator: (val) => viewModel.validateName(val),
                keyboardType: TextInputType.name,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          hintText: context.localization.email,
          keyboardType: TextInputType.emailAddress,
          controller: viewModel.emailController,
          labelText: context.localization.emailAddress,
          validator: (val) => viewModel.validateEmail(val),
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          isPasswordVisible: viewModel.isPasswordVisible,
          showPassword: viewModel.togglePasswordVisibility,
          hintText: context.localization.password,
          keyboardType: TextInputType.visiblePassword,
          controller: viewModel.passwordController,
          labelText: context.localization.password,
          validator: (val) => viewModel.validatePassword(val),
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          hintText: context.localization.confirmPassword,
          isPasswordVisible: viewModel.isRePasswordVisible,
          showPassword: viewModel.toggleRePasswordVisibility,
          keyboardType: TextInputType.visiblePassword,
          controller: viewModel.rePasswordController,
          labelText: context.localization.confirmPassword,
          validator: (val) => viewModel.validateConfirmPassword(
              val, viewModel.passwordController.text),
        ),
        const SizedBox(height: 20),
        CustomAuthButton(
          text: context.localization.next,
          onPressed: viewModel.nextStep,
          color: const Color(0xFF102027),
        ),
      ],
    );
  }
}
