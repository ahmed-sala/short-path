import 'package:flutter/material.dart';
import '../../../../config/routes/routes_name.dart';
import '../../../../core/styles/colors/app_colore.dart';
import '../../../../core/widgets/custom_auth_button.dart';
import '../../../../core/widgets/custom_auth_text_feild.dart';
import '../../../../main.dart';

class OtpScreen extends StatelessWidget {
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();

  OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            const SizedBox(height: 130),
            Text(
              'OTP Verification',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Enter the 4-digit code sent to your email.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.greyColor,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOtpTextField(otpController1),
                _buildOtpTextField(otpController2),
                _buildOtpTextField(otpController3),
                _buildOtpTextField(otpController4),
              ],
            ),
            const SizedBox(height: 40),
            CustomAuthButton(
              text: 'VERIFY',
              onPressed: () {
                String otp = otpController1.text +
                    otpController2.text +
                    otpController3.text +
                    otpController4.text;
                navKey.currentState!.pushNamed(RoutesName.newpassword);
                print('Entered OTP: $otp');
                // Add navigation or verification logic here
              },
              color: AppColors.secondaryColor,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't Receive Code? ",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.greyColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('Resend OTP');
                    // Add resend OTP logic here
                  },
                  child: Text(
                    'Resend',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpTextField(TextEditingController controller) {
    return SizedBox(
      width: 50,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.greyColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.greyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.secondaryColor),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
      ),
    );
  }
}
