import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../design_system/dimens/app_spacing.dart';
import '../../modules/metronome/metronome_controller.dart';
import '../sliders/custom_slider_widget.dart';
import '../styles/app_text_styles.dart';

class BpmChangeCardWidget extends StatelessWidget {
  final MetronomeController controller;

  const BpmChangeCardWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.medium(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => controller.setEnableBpmChange(!controller.enableBpmChange),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mudar BPM automaticamente',
                    style: AppTextStyles.subTitleTextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  Observer(
                    builder: (_) => Switch(
                      value: controller.enableBpmChange,
                      onChanged: controller.setEnableBpmChange,
                      activeThumbColor: Theme.of(context).colorScheme.onPrimary,
                      inactiveTrackColor: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Observer(
              builder: (_) {
                if (!controller.enableBpmChange) return const SizedBox.shrink();

                return Column(
                  children: [
                    CustomSliderWidget(
                      label: 'Compassos antes da mudança',
                      value: controller.measuresToChange.toDouble(),
                      min: 1,
                      max: 32,
                      divisions: 31,
                      onChanged: (v) => controller.setMeasuresToChange(v.toInt()),
                    ),
                    const SizedBox(height: 12),
                    CustomSliderWidget(
                      label: 'Incremento de BPM',
                      value: controller.bpmChangeValue,
                      min: -20,
                      max: 20,
                      divisions: 40,
                      onChanged: controller.setBpmChangeValue,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
