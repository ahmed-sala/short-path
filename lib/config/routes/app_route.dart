import 'package:flutter/material.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/src/presentation/screens/screen/home/home_screen.dart';
import 'package:short_path/src/auth/presentation/screens/login_screen.dart';
import 'package:short_path/src/auth/presentation/screens/new%20password_screen.dart';
import 'package:short_path/src/onboarding/presentation/screens/auth_decision.dart';
import 'package:short_path/src/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:short_path/src/splash/presentation/splash_screen.dart';

import '../../src/presentation/screens/screen/auth/login_screen.dart';
import '../../src/presentation/screens/screen/auth/register_screen.dart';
import '../../src/presentation/screens/screen/onboarding/auth_decision.dart';
import '../../src/presentation/screens/screen/onboarding/onboarding_screen.dart';
import '../../src/auth/presentation/screens/otp_Screen.dart';
import '../../src/auth/presentation/screens/password changed_screen.dart';
import '../../src/auth/presentation/screens/register_screen.dart';
import '../../src/auth/presentation/screens/reset password_screen.dart';

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
      case RoutesName.resetpassword:
        return _handelMaterialPageRoute(
            settings: settings, widget:  ResetPasswordScreen());
      case RoutesName.otp:
        return _handelMaterialPageRoute(
            settings: settings, widget:  OtpScreen());
      case RoutesName.newpassword:
        return _handelMaterialPageRoute(
            settings: settings, widget: NewPasswordScreen());
        case RoutesName.passwordchanged:
          return _handelMaterialPageRoute(
              settings: settings, widget: PasswordChangedScreen());
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
