import 'package:flutter/material.dart';

class CustomSnackBar {
  CustomSnackBar({
    required BuildContext context,
    required String message,
    required Color color,
  }) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }
}
