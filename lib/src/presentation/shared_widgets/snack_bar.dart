import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String message,
  Color backgroundColor, {
  String? actionLabel,
  VoidCallback? onActionPressed,
}) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  scaffoldMessenger.hideCurrentSnackBar();
  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      action: actionLabel != null && onActionPressed != null
          ? SnackBarAction(
              label: actionLabel,
              onPressed: onActionPressed,
              textColor: Colors.white,
            )
          : null,
    ),
  );
}
