import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SigninWithGoogleButton extends StatelessWidget {
  const SigninWithGoogleButton({super.key, this.onTap});

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Center(
          child: SvgPicture.asset('assets/images/svg/google.svg', width: 42),
        ),
      ),
    );
  }
}
