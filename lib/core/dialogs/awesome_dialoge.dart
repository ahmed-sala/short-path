import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

showAwesomeDialog(BuildContext context,
    {required String title,
    required String desc,
    required void Function() onOk,
    void Function()? onCancel, // Made onCancel optional
    required DialogType dialogType}) {
  AwesomeDialog(
    context: context,
    dialogType: dialogType,
    animType: AnimType.rightSlide,
    title: title,
    desc: desc,
    btnCancelOnPress: onCancel != null
        ? () {
            FocusScope.of(context).unfocus();
            onCancel();
          }
        : null,
    btnOkOnPress: () {
      FocusScope.of(context).unfocus();
      onOk();
    },
  ).show();
}

void showCustomDialog(
  BuildContext context, {
  required String title,
  required String message,
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
}) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onCancel != null) onCancel();
            },
            child: Text("Cancel", style: TextStyle(color: Colors.grey[700])),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent, // Red confirm button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Confirm", style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}
