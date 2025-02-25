import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/shared_widgets/date_input_feild.dart';

import '../../../mangers/auth/register/register_viewmodel.dart';
import '../../../shared_widgets/custom_auth_button.dart';
import '../../../shared_widgets/custom_auth_text_feild.dart';

class SecondStepRegister extends StatelessWidget {
  const SecondStepRegister({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<RegisterViewModel>();
    return Column(
      children: [
        CustomTextFormField(
          hintText: 'Enter your phone number',
          keyboardType: TextInputType.phone,
          controller: viewModel.phoneController,
          labelText: 'Phone Number',
          validator: (val) => viewModel.validatePhoneNumber(val),
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          hintText: 'Enter your Address',
          keyboardType: TextInputType.text,
          controller: viewModel.addressController,
          labelText: 'Address',
          validator: (val) => viewModel.validateAddress(val),
        ),
        const SizedBox(height: 20),
        DateInputField(
            selectedDate: viewModel.selectedDate,
            onDateSelected: viewModel.updateSelectedDate),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => viewModel.updateSelectedGender('Male'),
              child: Row(
                children: [
                  Radio<String>(
                    value: 'Male',
                    groupValue: viewModel.selectedGender,
                    onChanged: (value) =>
                        viewModel.updateSelectedGender(value!),
                    fillColor:
                        MaterialStateProperty.all(AppColors.primaryColor),
                    overlayColor:
                        MaterialStateProperty.all(AppColors.primaryColor),
                    focusColor: AppColors.primaryColor,
                    hoverColor: AppColors.primaryColor,
                  ),
                  const Text('Male'),
                ],
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () => viewModel.updateSelectedGender('Female'),
              child: Row(
                children: [
                  Radio<String>(
                    fillColor:
                        MaterialStateProperty.all(AppColors.primaryColor),
                    overlayColor:
                        MaterialStateProperty.all(AppColors.primaryColor),
                    focusColor: AppColors.primaryColor,
                    hoverColor: AppColors.primaryColor,
                    value: 'Female',
                    groupValue: viewModel.selectedGender,
                    onChanged: (value) =>
                        viewModel.updateSelectedGender(value!),
                  ),
                  const Text('Female'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomAuthButton(
                text: 'BACK',
                onPressed: viewModel.previousStep,
                color: const Color(0xFF102027),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: CustomAuthButton(
                text: 'REGISTER',
                onPressed: viewModel.validate ? viewModel.nextStep : null,
                color: viewModel.validate
                    ? const Color(0xFF102027)
                    : const Color(0xFFB0BC5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
