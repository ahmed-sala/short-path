sealed class LoginScreenState {}

class InitialState extends LoginScreenState {}

class LoadingState extends LoginScreenState {}

class ErrorState extends LoginScreenState {
  Exception? exception;
  ErrorState(this.exception);
}

class SuccessState extends LoginScreenState {}

class NavigateToHomeState extends LoginScreenState {}

class PasswordVisibilityState extends LoginScreenState {
  final bool isPasswordVisible;

  PasswordVisibilityState({
    required this.isPasswordVisible,
  });
}

class GoToRegisterState extends LoginScreenState {}

class ValidateColorButtonState extends LoginScreenState {}

class NavigateToFogotPasswordState extends LoginScreenState {}
