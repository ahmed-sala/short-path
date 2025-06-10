import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:short_path/config/helpers/shared_pref/shared_pre_keys.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../../config/routes/routes_name.dart';

// Import your ButtonsSectionWidget
import '../../../shared_widgets/buttons_section_widget.dart';

class PostRegisterChoiceScreen extends StatelessWidget {
  const PostRegisterChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Two callbacks: one for “continue to home” and one for “fill in CV”
    void onContinueToHome() {
      getIt<SharedPreferences>().setBool(SharedPrefKeys.completeCv, false);
      navKey.currentState?.pushNamedAndRemoveUntil(
        RoutesName.sectionScreen,
        (Route<dynamic> route) => false,
      );
    }

    void onFillInCv() {
      getIt<SharedPreferences>().setBool(SharedPrefKeys.completeCv, true);
      navKey.currentState?.pushNamedAndRemoveUntil(
        RoutesName.profile,
        (Route<dynamic> route) => false,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization.welcomeB),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // A Card-style container for the welcome message
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      context.localization.welcomeToShortPath,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      context.localization.whatWouldYouLikeToDoNext,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Use your ButtonsSectionWidget here
              ButtonsSectionWidget(
                onGenerateCvTap: onFillInCv,
                onGenerateCoverSheetTap: onContinueToHome,
                boldButtonText: context.localization.fillInYourCV,
                outlineButtonText: context.localization.continueToHome,
                outlineButtonIcon: Icons.home_outlined,
              ),

              const SizedBox(height: 16),
              Text(
                context.localization.youCanAlwaysUpdateYourCVLaterFromProfile,
                style: TextStyle(fontSize: 14, color: Colors.black45),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
