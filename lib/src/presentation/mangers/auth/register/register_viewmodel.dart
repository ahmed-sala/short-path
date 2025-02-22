// register_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';
import 'package:short_path/src/domain/usecases/auth/auth_use_case.dart';

import '../../../../data/api/core/error/error_handler.dart';
import 'register_states.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterScreenState> {
  final AuthUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase) : super(InitialState());

  // Controllers for form fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Additional properties
  DateTime? selectedDate;
  String selectedGender = "Male";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // UI-related flags
  bool isPasswordVisible = true;
  bool isRePasswordVisible = true;
  bool validate = false;
  int currentStep = 0;

  /// Toggle the visibility of the password field.
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityState(
      isPasswordVisible: isPasswordVisible,
      isRePasswordVisible: isRePasswordVisible,
    ));
  }

  /// Toggle the visibility of the confirm password field.
  void toggleRePasswordVisibility() {
    isRePasswordVisible = !isRePasswordVisible;
    emit(PasswordVisibilityState(
      isPasswordVisible: isPasswordVisible,
      isRePasswordVisible: isRePasswordVisible,
    ));
  }

  /// Proceed to the next step of the form.
  /// If already at the final step, perform registration.
  void nextStep() {
    if (currentStep < 1) {
      currentStep++;
      emit(ValidateColorButtonState());
    } else {
      _register();
    }
  }

  /// Go back to the previous step.
  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      emit(ValidateColorButtonState());
    }
  }

  /// Update the selected birthdate.
  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    emit(ValidateColorButtonState());
  }

  /// Update the selected gender.
  void updateSelectedGender(String gender) {
    selectedGender = gender;
    emit(ValidateColorButtonState());
  }

  /// Validate the form fields to determine if the "REGISTER" button should be enabled.
  void validateColorButton() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        rePasswordController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty) {
      validate = false;
    } else if (formKey.currentState == null ||
        !formKey.currentState!.validate()) {
      validate = false;
    } else {
      validate = true;
    }
    emit(ValidateColorButtonState());
  }

  /// Perform the registration process.
  Future<void> _register() async {
    if (formKey.currentState?.validate() != true) return;
    emit(LoadingState());
    try {
      if (selectedDate == null) {
        emit(ErrorState("Birthdate is required"));
        return;
      }
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
      // Convert gender to expected value (e.g., '0' for Male, '1' for Female)
      String genderValue = selectedGender == 'Male' ? '0' : '1';

      // Build the AppUser model
      AppUser appUser = AppUser(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        mobileNumber: phoneController.text.trim(),
        birthDate: formattedDate,
        address: addressController.text.trim(),
        gender: genderValue,
      );

      // Attempt registration using the provided use case
      final result = await _registerUseCase.registerInvoke(appUser);
      switch (result) {
        case Success<void>():
          emit(SuccessState());
          break;
        case Failures<void>():
          var errorMessage =
              ErrorHandler.fromException(result.exception).errorMessage;
          emit(ErrorState(errorMessage));
      }
    } catch (e) {
      emit(ErrorState('Unknown error'));
    }
  }

  /// Helper validation method for names.
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  /// Helper validation method for email.
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Additional email validation logic can be added here.
    return null;
  }

  /// Helper validation method for password.
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  /// Helper validation method for confirm password.
  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Helper validation method for phone number.
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    return null;
  }

  /// Helper validation method for address.
  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    return null;
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    phoneController.dispose();
    addressController.dispose();
    return super.close();
  }
}
