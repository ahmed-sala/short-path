import 'package:flutter/material.dart';

class AuthDecision extends StatelessWidget {
  const AuthDecision({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: const Text('Go to Login'),
        ),
      ),
    );
  }
}
