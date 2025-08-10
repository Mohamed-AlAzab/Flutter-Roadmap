import 'package:flutter/material.dart';

class CoustomTextFormField extends StatelessWidget {
  const CoustomTextFormField({
    super.key,
    required this.text,
    this.obscureText = false,
    required this.validator,
    required this.hintColor,
    required this.fillColor, required this.controller,
  });

  final TextEditingController controller;
  final String text;
  final Color hintColor;
  final Color fillColor;
  final bool obscureText;
  final FormFieldValidator validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      style: TextStyle(color: hintColor),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: fillColor,
        hintText: text,
        hintStyle: TextStyle(color: hintColor),
      ),
    );
  }
}
