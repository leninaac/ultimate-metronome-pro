import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/metronome/metronome_controller.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/styles/app_text_styles.dart';
import 'package:ultimate_metronome_pro/design_system/dimens/app_spacing.dart';

class CustomBpmModalContentWidget extends StatelessWidget {
  final MetronomeController controller;

  const CustomBpmModalContentWidget({super.key, required this.controller});

  static const int minBpm = 20;
  static const int maxBpm = 300;
  static const int bpmRange = maxBpm - minBpm + 1;

  @override
  Widget build(BuildContext context) {
    // Calcula o índice inicial baseado no BPM atual, garantindo que esteja no range válido
    final initialBpm = controller.bpm.round().clamp(minBpm, maxBpm);
    final initialIndex = initialBpm - minBpm;
    final bpmController = FixedExtentScrollController(initialItem: initialIndex);

    return Padding(
      padding: EdgeInsets.all(AppSpacing.medium(context)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'BPM',
            style: AppTextStyles.regularTextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          SizedBox(height: AppSpacing.small(context)),
          SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // BPM Picker (20..300)
                SizedBox(
                  width: 120,
                  height: 70,
                  child: CupertinoPicker(
                    scrollController: bpmController,
                    itemExtent: 32,
                    onSelectedItemChanged: (index) {
                      // O valor do BPM é o índice + o BPM mínimo
                      final value = (index + minBpm).toDouble();
                      // Chama a ação do controller para atualizar o BPM e reiniciar o scheduler
                      controller.setBpm(value);
                    },
                    children: List.generate(bpmRange, (index) {
                      final value = index + minBpm;
                      return Center(
                        child: Text(
                          '$value',
                          style: AppTextStyles.regularTextStyle(color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: AppSpacing.small(context)),

          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:  Text('Salvar', style: AppTextStyles.regularTextStyle(color: Theme.of(context).colorScheme.onPrimary)),
            ),
          ),
        ],
      ),
    );
  }
}