import 'package:flutter/material.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/images/app_images.dart';
import 'package:short_path/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 4));
    print(navKey.currentState);
    // navKey.currentState!.pushReplacementNamed(RoutesName.onBoarding);
    Navigator.of(context).pushReplacementNamed(RoutesName.onBoarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset(AppImages.logo),
      ),
    );
  }
}
