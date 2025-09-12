import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/utils/helper.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    this.onTap,
    required this.isLoading,
    required this.text,
  });

  final VoidCallback? onTap;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? () {} : onTap,
      child: Container(
        width: context.width,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.onSurface,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: isLoading
                ? CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.surface,
                  )
                : Text(
                    text,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
