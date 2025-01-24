import 'package:flutter/material.dart';

class CustomDropdownButtonFormField<T> extends StatefulWidget {
  const CustomDropdownButtonFormField({
    super.key,
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.value,
    this.hintText,
    this.validator,
    this.custFocusNode,
  });

  final String? labelText;
  final String? hintText;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final FocusNode? custFocusNode;

  @override
  State<CustomDropdownButtonFormField<T>> createState() =>
      _CustomDropdownButtonFormFieldState<T>();
}

class _CustomDropdownButtonFormFieldState<T>
    extends State<CustomDropdownButtonFormField<T>> {
  // Focus node to track the focus of the DropdownButtonFormField
  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    // Listen to focus changes
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
    return SizedBox(
      // Constrain the width of the dropdown
      width: double.infinity, // Take up all available width
      child: DropdownButtonFormField<T>(
        focusNode: widget.custFocusNode ?? _focusNode,
        value: widget.value,
        items: widget.items,
        onChanged: widget.onChanged,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: _isFocused ? Colors.grey.shade600 : Colors.grey.shade400,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
          ),
          filled: true,
          fillColor: const Color(0xFFF4F4F4),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Color(0xFFDEDEDE),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
        ),
        dropdownColor:
            const Color(0xFFF4F4F4), // Background color of dropdown menu
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.grey.shade600,
        ),
        style: const TextStyle(
          color: Color(0xFF858383),
        ),
        isExpanded: true, // Make the dropdown take up all available width
      ),
    );
  }
}
