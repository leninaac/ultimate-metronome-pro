import 'package:flutter/material.dart';

import '../../../../design_system/typography/app_font_names.dart';
import '../../../../design_system/typography/app_font_sizes.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle appBarTitleTextStyle({required Color color}) {
    return TextStyle(
      fontFamily: AppFonts.montserratFont,
      fontWeight: FontWeight.w600,
      fontSize: AppFontSizes.bodyMedium,
      color: color,
    );
  }

  static TextStyle titleTextStyle({required Color color}) {
    return TextStyle(
      fontFamily: AppFonts.montserratFont,
      fontWeight: FontWeight.w600,
      fontSize: AppFontSizes.displaySmall,
      color: color,
    );
  }

  static TextStyle subTitleTextStyle({required Color color}) {
    return TextStyle(
      fontFamily: AppFonts.montserratFont,
      fontWeight: FontWeight.w600,
      fontSize: AppFontSizes.headlineMedium,
      color: color,
    );
  }

  static TextStyle regularTextStyle({required Color color}) {
    return TextStyle(
      fontFamily: AppFonts.montserratFont,
      fontWeight: FontWeight.w600,
      fontSize: AppFontSizes.bodyMedium,
      color: color,
    );
  }

  static TextStyle regularTextStyleSizeCustomized({required Color color, required double size}) {
    return TextStyle(
      fontFamily: AppFonts.montserratFont,
      fontWeight: FontWeight.w600,
      fontSize: size,
      color: color,
    );
  }
}
