import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';
import 'package:short_path/src/domain/usecases/auth/auth_use_case.dart';
import 'package:short_path/src/presentation/mangers/auth/register/register_actions.dart';
import 'package:short_path/src/presentation/mangers/auth/register/register_states.dart';

import '../../../../../core/common/api/api_result.dart';
import '../../../../data/api/core/error/error_handler.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterScreenState> {
  AuthUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase) : super(InitialState());

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  DateTime? selectedDate;
  String selectedGender = "Male";

  var formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  bool isRePasswordVisible = true;
  bool validate = false;

  void doAction(RegisterScreenActions action) {
    switch (action) {
      case RegisterAction():
        _register();
        break;
      case GoToLoginAction():
      case NavigateToHomeAction():
        _navigateToHome();
      case ValidateColorButtonAction():
        _validateColorButton();
    }
  }

  void _register() async {
    if (formKey.currentState!.validate()) {
      emit(LoadingState());
      try {
        print('the selected data is $selectedDate');
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
        if (selectedGender == 'Male') {
          selectedGender = '0';
        } else {
          selectedGender = '1';
        }
        AppUser appUser = AppUser(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            mobileNumber: phoneController.text.trim(),
            birthDate: formattedDate,
            address: addressController.text.trim(),
            gender: selectedGender);
        var result = await _registerUseCase.registerInvoke(appUser);
        switch (result) {
          case Success<void>():
            emit(SuccessState());
            break;
          case Failures<void>():
            validate = false;
            final error = ErrorHandler.fromException(result.exception);
            print('Error: ${error.errorMessage}, with code ${error.code}');
            emit(ErrorState(error.errorMessage));
            break;
        }
      } catch (e) {
        emit(ErrorState('Unknown error '));
      }
    }
  }

  void _navigateToHome() {
    emit(NavigateToHomeState());
  }

  void _validateColorButton() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        rePasswordController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty ||
        selectedDate != null) {
      validate = false;
    } else if (!formKey.currentState!.validate()) {
      validate = false;
    } else {
      validate = true;
    }
    emit(ValidateColorButtonState());
  }

  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    print('the selected date is $selectedDate');
    emit(ValidateColorButtonState());
  }

  void updateSelectedGender(String gender) {
    selectedGender = gender;
    emit(ValidateColorButtonState());
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
