import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/features/theme/bloc/theme_bloc.dart';
import 'package:flutter_roadmap/features/theme/domain/entity/theme_entity.dart';
import 'package:flutter_svg/svg.dart';

class SigninWithGithubButton extends StatelessWidget {
  const SigninWithGithubButton({super.key, this.onTap});

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
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return SvgPicture.asset(
                state.themeEntity?.themeType == ThemeType.dark
                    ? 'assets/images/svg/github_dark.svg'
                    : 'assets/images/svg/github_light.svg',
                width: 42,
              );
            },
          ),
        ),
      ),
    );
  }
}
