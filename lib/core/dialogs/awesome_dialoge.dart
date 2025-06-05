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
      return Dialog(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title Row: Icon + Text
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Message Text
              Text(
                message,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),

              // (Optional) Divider
              Divider(color: Colors.grey.shade300, thickness: 1),
              const SizedBox(height: 16),

              // Buttons Row
              Row(
                children: [
                  // Cancel Button (Outlined / Low Emphasis)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (onCancel != null) onCancel();
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade500),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Confirm Button (Filled / High Emphasis)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConfirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
