sealed class RegisterScreenState {}

class InitialState extends RegisterScreenState {}

class LoadingState extends RegisterScreenState {}

class ErrorState extends RegisterScreenState {
  Exception? exception;
  ErrorState(this.exception);
}

class SuccessState extends RegisterScreenState {
  SuccessState();
}

class GoToLoginState extends RegisterScreenState {}

class NavigateToHomeState extends RegisterScreenState {}

class PasswordVisibilityState extends RegisterScreenState {
  final bool isPasswordVisible;
  final bool isRePasswordVisible;

  PasswordVisibilityState({
    required this.isPasswordVisible,
    required this.isRePasswordVisible,
  });
}

class ValidateColorButtonState extends RegisterScreenState {}
