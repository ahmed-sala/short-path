import 'package:flutter/material.dart';
import 'package:short_path/config/helpers/validations.dart';
import 'package:short_path/core/widgets/custom_auth_text_feild.dart';
import '../../../../config/routes/routes_name.dart';
import '../../../../core/styles/colors/app_colore.dart';
import '../../../../core/widgets/custom_auth_button.dart';
import '../../../../main.dart';

class NewPasswordScreen extends StatefulWidget {
  NewPasswordScreen({super.key});
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey, // Add Form widget
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      'Create New Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Text(
                      'Your new password must be different\nfrom the previously used passwords.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.greyColor,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30.0),

                    // Password Field
                    CustomTextFormField(labelText: "password", hintText:"enter new password", keyboardType:TextInputType.visiblePassword, controller:passwordController , validator: (value) {
                      return Validations.validatePassword(value);
                    },showPassword:(){
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },isPasswordVisible: isPasswordVisible,),

                    const SizedBox(height: 20),

                    // Confirm Password Field
                    CustomTextFormField(labelText: 'Confirm Password', hintText:'Re-enter your password', keyboardType:TextInputType.visiblePassword, controller:confirmPasswordController, validator: (value) {
                      return Validations.validateConfirmPassword(value, passwordController.text);
                    },showPassword:(){
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },isPasswordVisible: isConfirmPasswordVisible,),



                    const SizedBox(height: 40),

                    // Reset Password Button
                    CustomAuthButton(
                      text: 'RESET PASSWORD',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, proceed to next screen
                          navKey.currentState!.pushNamed(RoutesName.passwordchanged);
                          print('Password reset successfully!');
                        }
                      },
                      color: AppColors.secondaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
