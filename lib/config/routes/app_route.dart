import 'package:flutter/material.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/src/presentation/screens/screen/user%20info/additional_info/additional_info_screen.dart';
import 'package:short_path/src/presentation/screens/screen/user%20info/certification/certification_screen.dart';
import 'package:short_path/src/presentation/screens/screen/user%20info/education_screen/main_education_screen.dart';
import 'package:short_path/src/presentation/screens/screen/user%20info/language/language_screen.dart';
import 'package:short_path/src/presentation/screens/screen/user%20info/profile_screen/profile_screen.dart';
import 'package:short_path/src/presentation/screens/screen/user%20info/project/project_screen.dart';
import 'package:short_path/src/presentation/screens/screen/user%20info/work_experience/work_experience_screen.dart';

import '../../src/presentation/screens/screen/auth/login_screen.dart';
import '../../src/presentation/screens/screen/auth/register_screen.dart';
import '../../src/presentation/screens/screen/home/home_screen.dart';
import '../../src/presentation/screens/screen/onboarding/auth_decision.dart';
import '../../src/presentation/screens/screen/onboarding/onboarding_screen.dart';
import '../../src/presentation/screens/screen/user info/skiils/skill_information_screen.dart';

class AppRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return _handelMaterialPageRoute(
            settings: settings, widget: const LoginScreen());
      case RoutesName.onBoarding:
        return _handelMaterialPageRoute(
            settings: settings, widget: OnboardingScreen());
      case RoutesName.authDecision:
        return _handelMaterialPageRoute(
            settings: settings, widget: const AuthDecision());
      case RoutesName.register:
        return _handelMaterialPageRoute(
            settings: settings, widget: const RegisterScreen());
      case RoutesName.home:
        return _handelMaterialPageRoute(
            settings: settings, widget: const HomeScreen());
      case RoutesName.profile:
        return _handelMaterialPageRoute(
            settings: settings, widget: const ProfileScreen());
      case RoutesName.education:
        return _handelMaterialPageRoute(
            settings: settings, widget: MainEducationScreen());

      case RoutesName.skillGathering:
        return _handelMaterialPageRoute(
            settings: settings, widget: const SkillInformationScreen());
      // case RoutesName.educationproject:
      //   return _handelMaterialPageRoute(
      //       settings: settings, widget: const EducationProjectScreen());

      case RoutesName.project:
        return _handelMaterialPageRoute(
            settings: settings, widget: const ProjectScreen());

      case RoutesName.certification:
        return _handelMaterialPageRoute(
            settings: settings, widget: CertificationScreen());

      case RoutesName.additionalinfo:
        return _handelMaterialPageRoute(
            settings: settings, widget: const AdditionalInfoScreen());

      case RoutesName.language:
        return _handelMaterialPageRoute(
            settings: settings, widget: const LanguageScreen());

      case RoutesName.workExperience:
        return _handelMaterialPageRoute(
            settings: settings, widget: const WorkExperienceScreen());

      default:
        return _handelMaterialPageRoute(
            settings: settings, widget: const Scaffold());
    }
  }

  static MaterialPageRoute<dynamic> _handelMaterialPageRoute(
      {required Widget widget, required RouteSettings settings}) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}
