import 'package:flutter/material.dart';

import 'custom_auth_text_feild.dart';

class DateInputFeild extends StatelessWidget {
  const DateInputFeild({
    super.key,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    required this.labelText,
  });

  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus && controller.text.isEmpty) {
          // Trigger suggestions when the field gains focus
          controller.text = ''; // Trigger the listener
        }
      },
      child: Column(
        children: [
          CustomTextFormField(
            hintText: hintText,
            keyboardType: keyboardType,
            controller: controller,
            labelText: labelText,
            validator: (val) => val == null || val.isEmpty
                ? 'Please enter the $hintText'
                : null,
          ),
        ],
      ),
    );
  }
}
