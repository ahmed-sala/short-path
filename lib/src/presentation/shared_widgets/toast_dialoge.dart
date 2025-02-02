import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/styles/colors/app_colore.dart';

class ToastDialog {
  static void show(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: AppColors.whiteColor,
      fontSize: 16.0,
    );
  }
}
