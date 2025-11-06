import 'package:flutter/material.dart';

import '../styles/app_text_styles.dart';

class CustomSliderWidget extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final ValueChanged<double> onChanged;
  const CustomSliderWidget({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    this.divisions,
    required this.onChanged,
});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${value.round()}',
          style: AppTextStyles.regularTextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          label: '${value.round()}',
          onChanged: onChanged,
          activeColor: Theme.of(context).colorScheme.onPrimary,
          inactiveColor: Theme.of(context).colorScheme.onTertiary,
        ),
      ],
    );
  }
}
