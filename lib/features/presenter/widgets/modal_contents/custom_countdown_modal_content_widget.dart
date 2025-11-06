import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/metronome/metronome_controller.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/timer/timer_controller.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/styles/app_text_styles.dart';
import 'package:ultimate_metronome_pro/design_system/dimens/app_spacing.dart';

class CustomCountdownModalContentWidget extends StatelessWidget {
  final TimerController controller;

  const CustomCountdownModalContentWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.medium(context)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Contagem Regressiva',
            style: AppTextStyles.regularTextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: AppSpacing.medium(context)),

          Observer(
            builder: (_) {
              final h = controller.countdownHours.toString().padLeft(2, '0');
              final m = controller.countdownMinutes.toString().padLeft(2, '0');
              final s = controller.countdownSeconds.toString().padLeft(2, '0');
              return Text(
                '$h:$m:$s',
                style: AppTextStyles.appBarTitleTextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              );
            },
          ),
          SizedBox(height: AppSpacing.medium(context)),

          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPicker(
                  context: context,
                  label: 'Horas',
                  itemCount: 24,
                  initialValue: controller.countdownHours,
                  onSelectedItemChanged: controller.setCountdownHours,
                ),
                _buildPicker(
                  context: context,
                  label: 'Minutos',
                  itemCount: 60,
                  initialValue: controller.countdownMinutes,
                  onSelectedItemChanged: controller.setCountdownMinutes,
                ),
                _buildPicker(
                  context: context,
                  label: 'Segundos',
                  itemCount: 60,
                  initialValue: controller.countdownSeconds,
                  onSelectedItemChanged: controller.setCountdownSeconds,
                ),
              ],
            ),
          ),

          SizedBox(height: AppSpacing.medium(context)),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Observer(
                builder: (_) {
                  final isRunning = controller.isCountdownRunning;
                  return IconButton(
                    icon: Icon(
                      isRunning ? Icons.pause : Icons.play_arrow,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () {
                      if (isRunning) {
                        controller.pauseCountdownTimer();
                      } else {
                        controller.startCountdownTimer(Modular.get<MetronomeController>());
                        Navigator.pop(context);
                      }
                    },

                  );
                },
              ),
              SizedBox(width: AppSpacing.medium(context)),
              IconButton(
                icon: Icon(
                  Icons.stop,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: controller.resetCountdownTimer,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPicker({
    required BuildContext context,
    required String label,
    required int itemCount,
    required int initialValue,
    required ValueChanged<int> onSelectedItemChanged,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.regularTextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        SizedBox(
          width: 80,
          height: 100,
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: initialValue),
            itemExtent: 32,
            onSelectedItemChanged: onSelectedItemChanged,
            children: List.generate(itemCount, (index) {
              return Center(
                child: Text(
                  index.toString().padLeft(2, '0'),
                  style: AppTextStyles.regularTextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
