import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData getTheme(bool isDark) {
    return ThemeData(
      useMaterial3: false,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: isDark ? AppColors.titleDark : AppColors.titleLight,
        onPrimary: isDark
            ? AppColors.backgroundItemDark
            : AppColors.backgroundItemLight,
        secondary: isDark ? AppColors.textDark : AppColors.textLight,
        onSecondary: isDark
            ? AppColors.backgroundItemDark
            : AppColors.backgroundItemLight,
        error: Colors.red,
        onError: Colors.white,
        surface: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        onSurface: isDark ? AppColors.buttonDark : AppColors.buttonLight,
      ),
    );
  }
}
