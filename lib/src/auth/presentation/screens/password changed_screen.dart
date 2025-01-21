import 'package:flutter/material.dart';
import '../../../../config/routes/routes_name.dart';
import '../../../../core/styles/colors/app_colore.dart';
import '../../../../core/widgets/custom_auth_button.dart';
import '../../../../main.dart';

class PasswordChangedScreen extends StatelessWidget {
  PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                // Success Icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check_circle,
                      size: 80,
                      color: Colors.green,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Title
                Text(
                  'Password Changed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor,
                  ),
                ),

                const SizedBox(height: 20),

                // Subtitle
                Text(
                  'Your password has been successfully updated.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.greyColor,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 40),

                // Back to Sign In Button
                CustomAuthButton(
                  text: 'BACK TO SIGN IN',
                  onPressed: () {
                    navKey.currentState!.pushNamed(RoutesName.login);
                  },
                  color: AppColors.secondaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
