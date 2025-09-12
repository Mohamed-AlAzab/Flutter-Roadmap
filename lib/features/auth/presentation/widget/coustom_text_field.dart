import 'package:flutter/material.dart';

class CoustomTextFormField extends StatefulWidget {
  const CoustomTextFormField({
    super.key,
    required this.text,
    this.obscureText = false,
    required this.validator,
    required this.controller,
  });

  final TextEditingController controller;
  final String text;
  final bool obscureText;
  final FormFieldValidator validator;

  @override
  State<CoustomTextFormField> createState() => _CoustomTextFormFieldState();
}

class _CoustomTextFormFieldState extends State<CoustomTextFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText ? _isObscure : false,
        validator: widget.validator,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
        decoration: InputDecoration(
          suffixIcon: widget.obscureText
              ? IconButton(
                  splashRadius: 20,
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null,
          errorStyle: TextStyle(height: 0.8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.onPrimary,
          hintText: widget.text,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
