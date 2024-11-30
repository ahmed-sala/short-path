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

  void doAction(RegisterScreenActions action) {}

  void _register() async {
    if (formKey.currentState!.validate()) {}
  }

  void _goToLogin() {
    emit(GoToLoginState());
  }

  void _navigateToHome() {
    emit(NavigateToHomeState());
  }
}
