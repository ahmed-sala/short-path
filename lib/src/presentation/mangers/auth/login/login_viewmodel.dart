import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';

import '../../../../data/api/core/error/error_handler.dart';
import '../../../../domain/usecases/auth/auth_use_case.dart';
import 'login_actions.dart';
import 'login_states.dart';

@injectable
class LoginViewModel extends Cubit<LoginScreenState> {
  AuthUseCase _loginUseCase;
  LoginViewModel(
    this._loginUseCase,
  ) : super(InitialState());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool validate = false;
  void doAction(LoginScreenActions action) {
    switch (action) {
      case LoginAction():
        _login();
        break;
      case NavigateToRegisterAction():
        _goToRegister();
        break;
      case NavigateToHomeAction():
        _navigateToHome();
        break;
      case ValidateColorButtonAction():
        _validateColorButton();
        break;
      case ShowPasswordAction():
      case NavigateToForgetPasswordAction():
        _navigateToForgetPassword();
        break;
    }
  }

  void _login() async {
    if (formKey.currentState!.validate()) {
      emit(LoadingState());
      try {
        var result = await _loginUseCase.loginInvoke(
            emailController.text, passwordController.text);
        switch (result) {
          case Success<void>():
            emit(SuccessState());
            break;
          case Failures<void>():
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
