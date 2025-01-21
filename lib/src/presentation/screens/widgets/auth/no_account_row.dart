import 'package:flutter/material.dart';

import '../../../../../../core/styles/colors/app_colore.dart';

class NoAccountRow extends StatelessWidget {
  const NoAccountRow(
      {super.key,
      required this.content,
      required this.actionText,
      required this.onPressed});
  final String content;
  final String actionText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          content,
          style: TextStyle(fontSize: 16.0, color: Color(0xFF858383)),
        ),
        const SizedBox(
          width: 8.0,
        ),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            actionText,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
