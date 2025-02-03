import 'package:flutter/material.dart';

import '../../src/presentation/shared_widgets/alert_dialog.dart';
import '../../src/short_path.dart';

showLoading(BuildContext context, String? message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        text: message,
      );
    },
  );
}

hideLoading() {
  if (navKey.currentState!.canPop()) {
    Navigator.of(navKey.currentContext!).pop();
  }
}
