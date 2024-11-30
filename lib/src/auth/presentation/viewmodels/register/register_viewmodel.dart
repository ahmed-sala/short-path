import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/src/auth/presentation/viewmodels/register/register_actions.dart';
import 'package:short_path/src/auth/presentation/viewmodels/register/register_states.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterScreenState> {
  RegisterViewModel() : super(InitialState());
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
    }
  }

  void _navigateToHome() {
    emit(NavigateToHomeState());
  }

  _validateColorButton() {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        rePasswordController.text.isEmpty ||
        phoneController.text.isEmpty) {
      validate = false;
    } else if (!formKey.currentState!.validate()) {
      validate = false;
    } else {
      validate = true;
    }
    emit(ValidateColorButtonState());
  }
}
