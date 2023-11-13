import 'package:flutter/material.dart';
import 'package:orgasync/src/config/theme/colors.dart';

class AppTheme {
  // theme data
  static ThemeData get themeData => _themeData;

  // dark theme data
  static ThemeData get darkThemeData => _darkThemeData;

  static final ThemeData _themeData = ThemeData(
    colorScheme: AppColors.schemeLight,
    useMaterial3: true,
    fontFamily: "Poppins",
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
  );

  static final ThemeData _darkThemeData = ThemeData(
    colorScheme: AppColors.schemeDark,
    useMaterial3: true,
    fontFamily: "Poppins",
  );
}
