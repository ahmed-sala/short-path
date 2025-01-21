import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key, this.text});
  final String? text;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            width: 16,
          ),
          Text(text!),
        ],
      ),
    );
  }
}
