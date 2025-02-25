import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                hintText: 'First name',
                controller: viewModel.firstNameController,
                labelText: 'First Name',
                validator: (val) => viewModel.validateName(val),
                keyboardType: TextInputType.name,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: CustomTextFormField(
                hintText: 'Last name',
                controller: viewModel.lastNameController,
                labelText: 'Last Name',
                validator: (val) => viewModel.validateName(val),
                keyboardType: TextInputType.name,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          controller: viewModel.emailController,
          labelText: 'Email Address',
          validator: (val) => viewModel.validateEmail(val),
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          isPasswordVisible: viewModel.isPasswordVisible,
          showPassword: viewModel.togglePasswordVisibility,
          hintText: 'Password',
          keyboardType: TextInputType.visiblePassword,
          controller: viewModel.passwordController,
          labelText: 'Password',
          validator: (val) => viewModel.validatePassword(val),
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          hintText: 'Confirm Password',
          isPasswordVisible: viewModel.isRePasswordVisible,
          showPassword: viewModel.toggleRePasswordVisibility,
          keyboardType: TextInputType.visiblePassword,
          controller: viewModel.rePasswordController,
          labelText: 'Confirm Password',
          validator: (val) => viewModel.validateConfirmPassword(
              val, viewModel.passwordController.text),
        ),
        const SizedBox(height: 20),
        CustomAuthButton(
          text: 'NEXT',
          onPressed: viewModel.nextStep,
          color: const Color(0xFF102027),
        ),
      ],
    );
  }
}
