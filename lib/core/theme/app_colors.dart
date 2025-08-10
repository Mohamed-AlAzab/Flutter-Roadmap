import 'package:flutter/material.dart';

/// A utility class that defines the color palette for the application,
/// supporting both light and dark themes.
///
/// This class contains static constant color values to maintain
/// consistent design across the app.
///
/// ## Usage
/// ```dart
/// Container(
///   color: AppColors.backgroundLight,
/// );
/// ```
class AppColors {
  // -----------------------------
  // Light Theme Colors
  // -----------------------------

  /// Primary color for titles and headings in the light theme.
  static const Color titleLight = Color(0xff0D141C); // 1 - primary

  /// Background color for screens and surfaces in the light theme.
  static const Color backgroundLight = Color(0xffFAFAFA); // 2 - surface

  /// Secondary color used for text and less prominent elements in the light theme.
  static const Color textLight = Color(0xff4A739C); // 3 - secondary

  /// Background color for items like cards or containers in the light theme.
  static const Color backgroundItemLight = Color(
    0xffE8EDF5,
  ); // 4 - onPrimary - onSecondary

  /// Primary button color in the light theme.
  static const Color buttonLight = Color(0xff0D78F2); // 5 - onSurface

  // -----------------------------
  // Dark Theme Colors
  // -----------------------------

  /// Secondary text color used in the dark theme.
  static const Color textDark = Color(0xff96BEEB); // 1 - secondary

  /// Background color for screens and surfaces in the dark theme.
  static const Color backgroundDark = Color(0xff0D141C); // 2 - surface

  /// Primary color for titles and headings in the dark theme.
  static const Color titleDark = Color(0xffE8EDF2); // 3 - primary

  /// Background color for items like cards or containers in the dark theme.
  static const Color backgroundItemDark = Color(
    0xff28333F,
  ); // 4 - onPrimary - onSecondary

  /// Primary button color in the dark theme.
  static const Color buttonDark = Color(0xff0D78F2); // 5 - onSurface
}
