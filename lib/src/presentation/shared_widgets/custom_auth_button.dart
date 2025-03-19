import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.textColor = Colors.white,
    this.validate = true,
    this.borderColor,
    this.borderRadius,
    this.textStyle,
  });

  final String? text;
  final void Function()? onPressed;
  final Color color;
  final Color? textColor;
  final Color? borderColor;
  final bool validate;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;

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
          borderRadius:
              borderRadius != null ? borderRadius! : BorderRadius.circular(10),
          side: borderColor != null
              ? BorderSide(color: borderColor!, width: 1.0)
              : BorderSide.none,
        ),
      ),
      child: Text(
        text ?? '',
        style: textStyle ??
            TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              color:
                  validate ? textColor : Colors.black54, // Disabled text color
            ),
      ),
    );
  }
}
