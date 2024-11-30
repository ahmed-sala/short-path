import 'package:flutter/material.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/src/auth/presentation/screens/login_screen.dart';
import 'package:short_path/src/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:short_path/src/splash/presentation/splash_screen.dart';

class AppRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return _handelMaterialPageRoute(
            settings: settings, widget: const SplashScreen());
      case RoutesName.login:
        return _handelMaterialPageRoute(
            settings: settings, widget: const LoginScreen());
      case RoutesName.onBoarding:
        return _handelMaterialPageRoute(
            settings: settings, widget: OnboardingScreen());
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
