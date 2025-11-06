import 'package:flutter/material.dart';
import '../../design_system/colors/app_colors.dart';
import '../../features/presenter/widgets/styles/app_text_styles.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.backgroundPrimary,
      onPrimary: AppColors.neonCyan,
      secondary: AppColors.backgroundPrimary,
      onSecondary: AppColors.surfaceSecondary,
      surface: AppColors.backgroundPrimary,
      onSurface: AppColors.neonCyan,
      error: AppColors.feedbackError,
      onTertiary: AppColors.textInactive,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundPrimary,
      foregroundColor: AppColors.surfaceSecondary,
      elevation: 0,
    ),
    cardColor: AppColors.surfaceSecondary,
    cardTheme: CardThemeData(
      color: AppColors.surfaceSecondary,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    sliderTheme: SliderThemeData(
      valueIndicatorColor: AppColors.neonCyan,
      valueIndicatorTextStyle: AppTextStyles.regularTextStyle(color: AppColors.backgroundPrimary),
      showValueIndicator: ShowValueIndicator.onDrag,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.backgroundPrimary,
      onPrimary: AppColors.neonCyan,
      secondary: AppColors.backgroundPrimary,
      onSecondary: AppColors.surfaceSecondary,
      surface: AppColors.backgroundPrimary,
      onSurface: AppColors.neonCyan,
      error: AppColors.feedbackError,
      onTertiary: AppColors.textInactive,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundPrimary,
      foregroundColor: AppColors.surfaceSecondary,
      elevation: 0,
    ),
    cardColor: AppColors.surfaceSecondary,
    cardTheme: CardThemeData(
      color: AppColors.surfaceSecondary,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    sliderTheme: SliderThemeData(
      valueIndicatorColor: AppColors.neonCyan,
      valueIndicatorTextStyle: const TextStyle(
        color: AppColors.backgroundPrimary,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
      showValueIndicator: ShowValueIndicator.onDrag,
    ),
  );
}