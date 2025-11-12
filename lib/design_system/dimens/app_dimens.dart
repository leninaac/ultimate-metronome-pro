
class AppDimens {
  AppDimens._();

  // Border
  static const double defaultBorderWidth = 2.0;
  static const double cardBorderRadius = 12.0;

  // Spacing Factors
  static const double playButtonMarginFactor = 0.05;
  static const double beatIndicatorHorizontalPaddingFactor = 0.02;
  static const double beatIndicatorItemPaddingFactor = 0.04;

  // Sizing Factors
  static const double activeBeatIndicatorSizeFactor = 0.75;
  static const double inactiveBeatIndicatorSizeFactor = 0.65;

  // BPM Values
  static const double minBpmSlider = 1.0;
  static const double maxBpmSlider = 300.0;
  static const int minBpmPicker = 20;
  static const int maxBpmPicker = 300;

  // Slider Values
  static const double minMeasuresToChange = 1.0;
  static const double maxMeasuresToChange = 32.0;
  static const double minBpmChangeValue = -20.0;
  static const double maxBpmChangeValue = 20.0;
}
