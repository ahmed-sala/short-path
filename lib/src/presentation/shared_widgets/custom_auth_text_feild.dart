import 'package:flutter/material.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    required this.validator,
    this.isPasswordVisible = true,
    this.showPassword,
    this.onChanged,
    this.custfocusNode,
  });

  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  bool isPasswordVisible;
  void Function()? showPassword;
  void Function(String)? onChanged;
  final FocusNode? custfocusNode;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSummaryField = widget.labelText == context.localization.bioSummary;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: TextFormField(
        focusNode: widget.custfocusNode ?? _focusNode,
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: (_isFocused && widget.showPassword == null)
              ? const Icon(Icons.edit, color: AppColors.primaryColor)
              : null,
          suffixIcon: (_isFocused && widget.showPassword != null)
              ? IconButton(
                  onPressed: widget.showPassword,
                  icon: Icon(
                    widget.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey.shade600,
                  ),
                )
              : null,
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                const BorderSide(color: AppColors.primaryColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        ),
        onChanged: widget.onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText:
            widget.showPassword == null ? false : widget.isPasswordVisible,
        validator: widget.validator,
        keyboardType:
            isSummaryField ? TextInputType.multiline : widget.keyboardType,
        maxLines: isSummaryField ? 5 : 1,
        style: const TextStyle(
          color: Color(0xFF858383),
        ),
      ),
    );
  }
}
