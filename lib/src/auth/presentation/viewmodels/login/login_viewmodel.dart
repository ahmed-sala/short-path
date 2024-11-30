import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'login_actions.dart';
import 'login_states.dart';

@injectable
class LoginViewModel extends Cubit<LoginScreenState> {
  LoginViewModel() : super(InitialState());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool validate = false;
  void doAction(LoginScreenActions action) {
    switch (action) {
      case LoginAction():
      // TODO: Handle this case.
      case NavigateToRegisterAction():
      // TODO: Handle this case.
      case NavigateToHomeAction():
      // TODO: Handle this case.
      case ValidateColorButtonAction():
        _validateColorButton();
      case ShowPasswordAction():
      // TODO: Handle this case.
      case NavigateToForgetPasswordAction():
      // TODO: Handle this case.
    }
  }

  void _login() async {
    if (formKey.currentState!.validate()) {
      emit(LoadingState());
    }
  }

  void _navigateToHome() {
    emit(NavigateToHomeState());
  }

  void updateValidation() {
    validate = formKey.currentState?.validate() ?? false;
    emit(ValidateColorButtonState()); // Emit state change
  }

  _validateColorButton() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      validate = false;
    } else if (!formKey.currentState!.validate()) {
      validate = false;
    } else {
      validate = true;
    }
    emit(ValidateColorButtonState());
  }

  void _goToRegister() {
    emit(GoToRegisterState());
  }

  void _navigateToForgetPassword() {
    emit(NavigateToFogotPasswordState());
  }
}
