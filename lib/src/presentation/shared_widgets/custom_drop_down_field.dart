import 'package:flutter/material.dart';

class CustomDropDownField extends StatelessWidget {
  const CustomDropDownField({
    super.key,
    required this.value,
    required this.hintText,
    required this.items,
    required this.onChanged,
    required this.validator,
    required this.label,
  });

  final String value;
  final String hintText;
  final List<String> items;
  final void Function(String) onChanged;
  final String? Function(String?) validator;
  final String label;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      // If value is empty, pass null instead.
      value: value.isEmpty ? null : value,
      hint: Text(hintText),
      items: items.map((String itemValue) {
        return DropdownMenuItem<String>(
          value: itemValue,
          child: Text(itemValue),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
    );
  }
}
