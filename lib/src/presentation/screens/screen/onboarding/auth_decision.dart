import 'package:flutter/material.dart';
import 'package:short_path/core/extensions/extensions.dart';

import '../../../../../../config/routes/routes_name.dart';
import '../../../../../../core/styles/colors/app_colore.dart';
import '../../../../short_path.dart';
import '../../../shared_widgets/custom_auth_button.dart';

class AuthDecision extends StatelessWidget {
  const AuthDecision({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          Image.asset(
            'assets/images/onboarding4.png',
            width: 400,
            height: 400,
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              context.localization.joinTheShortPathCommunity,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              context.localization.getStartedByJoiningShortPath,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.greyColor,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 32.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomAuthButton(
                      text: context.localization.signIn,
                      onPressed: () {
                        navKey.currentState!
                            .pushReplacementNamed(RoutesName.login);
                      },
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        navKey.currentState!
                            .pushReplacementNamed(RoutesName.register);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.whiteColor,
                        side: const BorderSide(
                          color: AppColors.primaryColor,
                          width: 1.0,
                        ),
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: Text(
                        context.localization.signUp,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
