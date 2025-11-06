import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 1024;
  static const double _desktopBreakpoint = 1440;

  static double _scale(BuildContext context, double base) {
    final width = MediaQuery.of(context).size.width;

    if (width < _mobileBreakpoint) {
      return base * 0.9;
    } else if (width < _tabletBreakpoint) {
      return base;
    } else if (width < _desktopBreakpoint) {
      return base * 1.2;
    } else {
      return base * 1.4;
    }
  }

  static double extraSmall(BuildContext context) => _scale(context, 4.0);
  static double small(BuildContext context)      => _scale(context, 8.0);
  static double medium(BuildContext context)     => _scale(context, 16.0);
  static double large(BuildContext context)      => _scale(context, 24.0);
  static double extraLarge(BuildContext context) => _scale(context, 32.0);
  static double xxLarge(BuildContext context)    => _scale(context, 48.0);
  static double huge(BuildContext context)       => _scale(context, 64.0);
}
