import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/timer/timer_controller.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/styles/app_text_styles.dart';
import 'package:ultimate_metronome_pro/design_system/dimens/app_spacing.dart';

class CustomStopwatchModalContentWidget extends StatelessWidget {
  final TimerController controller;

  const CustomStopwatchModalContentWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.medium(context)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Cronômetro',
            style: AppTextStyles.regularTextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: AppSpacing.medium(context)),

          Observer(
            builder: (_) {
              final h = controller.stopwatchHours.toString().padLeft(2, '0');
              final m = controller.stopwatchMinutes.toString().padLeft(2, '0');
              final s = controller.stopwatchSeconds.toString().padLeft(2, '0');
              return Text(
                '$h:$m:$s',
                style: AppTextStyles.appBarTitleTextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              );
            },
          ),
          SizedBox(height: AppSpacing.medium(context)),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Observer(
                builder: (_) {
                  final isRunning = controller.isStopwatchRunning;
                  return IconButton(
                    icon: Icon(
                      isRunning ? Icons.pause : Icons.play_arrow,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () {
                      if (isRunning) {
                        controller.pauseStopwatch();
                      } else {
                        controller.startStopwatch();
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
                onPressed: controller.resetStopwatch,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
