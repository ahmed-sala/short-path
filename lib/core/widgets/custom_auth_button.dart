import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.textColor = Colors.white,
    this.validate = true,
  });

  final String? text;
  final void Function()? onPressed;
  final Color color;
  final Color? textColor;
  final bool validate;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: validate ? onPressed : null,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor:
            validate ? color : Colors.grey.shade400, // Disabled color
        minimumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Text(
        text ?? '',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          color: validate ? textColor : Colors.black54, // Disabled text color
        ),
      ),
    );
  }
}
