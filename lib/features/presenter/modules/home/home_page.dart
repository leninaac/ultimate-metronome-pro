import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ultimate_metronome_pro/design_system/strings/app_strings_portuguese.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/metronome/metronome_controller.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/timer/timer_controller.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/background/app_background_widget.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/buttons/custom_circular_button_widget.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/buttons/custom_rectangle_button_widget.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/modal_contents/custom_bpm_modal_content_widget.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/modal_contents/custom_countdown_modal_content_widget.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/paints/custom_circle_widget.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/styles/app_text_styles.dart';

import '../../../../consts/routes/app_routes.dart';
import '../../../../design_system/dimens/app_spacing.dart';
import '../../widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import '../../widgets/modal_contents/custom_stopwatch_modal_content_widget.dart';
import '../../widgets/paints/custom_beat_widget.dart';

class HomePage extends StatelessWidget {
  static const String routePath = AppRoutes.appHomePageRoute;

  static void push() => Modular.to.pushNamed(routePath);

  static void pop() => Modular.to.pop();

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<MetronomeController>();
    final timerController = Modular.get<TimerController>();

    return AppBackgroundWidget(
      appBar: CustomAppBarWidget(appBarType: AppBarType.centeredTitle, title: AppStringsPortuguese.appName),
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.small(context),
          right: AppSpacing.small(context),
          top: AppSpacing.extraSmall(context),
          bottom: AppSpacing.extraSmall(context),
        ),
        child: Column(
          children: [
            Observer(
              builder: (_) {
                final n = controller.numerator.clamp(1, 16);
                final activeIndex = controller.visualTickPosition;

                // altura relativa reservada para o bloco de círculos (ajuste percentual se desejar)
                final reservedHeightFactor = 0.12; // 12% da altura da tela, relativo e não absoluto

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final screenHeight = MediaQuery.of(context).size.height;
                    final reservedHeight = screenHeight * reservedHeightFactor;

                    return SizedBox(
                      height: reservedHeight, // fixa a altura do bloco para não empurrar outros widgets
                      child: Padding(
                        // padding horizontal relativo à largura disponível
                        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.02),
                        child: Row(
                          children: List.generate(n, (index) {
                            final isActive = index == activeIndex;

                            return Expanded(
                              child: Padding(
                                // padding relativo entre itens (1% da largura total)
                                padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.04),
                                child: Center(
                                  child: AspectRatio(
                                    aspectRatio: 1, // garante área quadrada para o círculo
                                    child: FractionallySizedBox(
                                      widthFactor: isActive ? 0.75 : 0.65, // circulo ativo pode ser um pouco maior
                                      heightFactor: isActive ? 0.75 : 0.65,
                                      child: CustomBeatWidget(
                                        // remova 'size' do CustomBeatWidget para permitir preenchimento do pai,
                                        // ou mantenha mas ele será ignorado se o widget não usa size.
                                        filled: isActive,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (ctx, constraints) {
                  final diameter = min(constraints.maxWidth, constraints.maxHeight) * 0.75;
                  final buttonSize = diameter * 0.225;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Observer(
                        builder: (context) {
                          return CustomCircleWidget(
                            size: diameter,
                            duration: timerController.getCountdownDuration(),
                            innerColor: Theme.of(context).colorScheme.onSurface,
                            outerColor: Theme.of(context).colorScheme.onSurface,
                            bpm: controller.bpm.round(),
                            bpmClicked: () => showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return CustomBottomSheetWidget(
                                  content: CustomBpmModalContentWidget(controller: controller),
                                );
                              },
                            ),
                            tempoLabel: controller.getMusicalTempoFromBpm(controller.bpm),
                            isCountdownActive: timerController.isCountdownRunning,
                            isBpmChangeWarning: controller.isBpmChangeWarningActive,
                            musicalSignature: '4/4',
                          );
                        },
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      Observer(
                        builder: (context) {
                          return CustomCircularButtonWidget(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            iconColor: Theme.of(context).colorScheme.onPrimary,
                            icon: Icon(!controller.metronomeIsRunning ? Icons.play_arrow : Icons.stop),
                            size: buttonSize,
                            borderColor: Theme.of(context).colorScheme.onPrimary,
                            borderWidth: 2,
                            onPressed: () {
                              if (!controller.metronomeIsRunning) {
                                controller.startMetronome();
                              } else {
                                // 1. Parar Metrônomo
                                controller.stopMetronome();

                                // 2. Parar Stopwatch (Pause funciona como Stop/Pause)
                                if (timerController.isStopwatchRunning) {
                                  timerController.pauseStopwatch();
                                }

                                // 3. Parar Countdown (Pause funciona como Stop/Pause)
                                if (timerController.isCountdownRunning) {
                                  timerController.pauseCountdownTimer();
                                  // Limpeza de estado: Recomendado para remover a flag de 'Countdown'
                                  timerController.setTimerType('Indefinido');
                                }
                              }
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: AppSpacing.small(context)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.medium(context)),
              child: Row(
                children: [
                  CustomCircularButtonWidget(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    iconColor: Theme.of(context).colorScheme.onPrimary,
                    icon: FittedBox(
                      child: Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                        child: Text(
                          '-5',
                          style: AppTextStyles.appBarTitleTextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                    size: MediaQuery.of(context).size.width * 0.10,
                    borderColor: Theme.of(context).colorScheme.onPrimary,
                    borderWidth: 2,
                    onPressed: () {
                      controller.setBpm(controller.bpm - 5);
                      if (controller.metronomeIsRunning) {
                        controller.restartMetronome();
                      }
                    },
                  ),
                  SizedBox(width: AppSpacing.medium(context)),
                  Expanded(
                    child: Observer(
                      builder: (context) {
                        return Slider(
                          value: controller.bpm,
                          min: 1,
                          max: 300,
                          label: controller.bpm.toInt().toString(),
                          onChanged: (double value) => controller.setBpm(value),
                          onChangeEnd: (double value) {
                            if (controller.metronomeIsRunning) {
                              controller.restartMetronome();
                            }
                          },
                          activeColor: Theme.of(context).colorScheme.onPrimary,
                          inactiveColor: Theme.of(context).colorScheme.onTertiary,
                        );
                      },
                    ),
                  ),
                  SizedBox(width: AppSpacing.medium(context)),
                  CustomCircularButtonWidget(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    iconColor: Theme.of(context).colorScheme.onPrimary,
                    icon: FittedBox(
                      child: Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                        child: Text(
                          '+5',
                          style: AppTextStyles.appBarTitleTextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                    size: MediaQuery.of(context).size.width * 0.10,
                    borderColor: Theme.of(context).colorScheme.onPrimary,
                    borderWidth: 2,
                    onPressed: () {
                      controller.setBpm(controller.bpm + 5);
                      if (controller.metronomeIsRunning) {
                        controller.restartMetronome();
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.large(context)),

            Card(
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
                            'Mudar BPM: ',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.regularTextStyle(color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          Observer(
                            builder: (context) {
                              return Switch(
                                value: controller.enableBpmChange,
                                onChanged: controller.setEnableBpmChange,
                                activeThumbColor: Theme.of(context).colorScheme.onPrimary,
                                inactiveTrackColor: Theme.of(context).colorScheme.onTertiary,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSpacing.medium(context)),
                    Observer(
                      builder: (_) {
                        if (!controller.enableBpmChange) return const SizedBox.shrink();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Compassos antes da mudança: ${controller.measuresToChange}',
                              style: AppTextStyles.regularTextStyle(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                            Slider(
                              value: controller.measuresToChange.toDouble(),
                              min: 1,
                              max: 32,
                              label: '${controller.measuresToChange}',
                              onChanged: (value) => controller.setMeasuresToChange(value.toInt()),
                              activeColor: Theme.of(context).colorScheme.onPrimary,
                              inactiveColor: Theme.of(context).colorScheme.onTertiary,
                            ),
                            SizedBox(height: AppSpacing.medium(context)),
                            Text(
                              'Incremento de BPM: ${controller.bpmChangeValue.round()}',
                              style: AppTextStyles.regularTextStyle(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                            Slider(
                              value: controller.bpmChangeValue,
                              min: -20,
                              max: 20,
                              label: '${controller.bpmChangeValue.round()}',
                              onChanged: controller.setBpmChangeValue,
                              activeColor: Theme.of(context).colorScheme.onPrimary,
                              inactiveColor: Theme.of(context).colorScheme.onTertiary,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppSpacing.medium(context)),

            Observer(
              builder: (_) {
                if (timerController.isStopwatchRunning) {
                  final h = timerController.stopwatchHours.toString().padLeft(2, '0');
                  final m = timerController.stopwatchMinutes.toString().padLeft(2, '0');
                  final s = timerController.stopwatchSeconds.toString().padLeft(2, '0');
                  return Text(
                    '$h:$m:$s',
                    style: AppTextStyles.appBarTitleTextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  );
                }

                if (timerController.isCountdownRunning) {
                  final h = timerController.countdownHours.toString().padLeft(2, '0');
                  final m = timerController.countdownMinutes.toString().padLeft(2, '0');
                  final s = timerController.countdownSeconds.toString().padLeft(2, '0');
                  return Text(
                    '$h:$m:$s',
                    style: AppTextStyles.appBarTitleTextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  );
                }

                return const SizedBox.shrink();
              },
            ),

            SizedBox(height: AppSpacing.medium(context)),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRectangleButtonWidget(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  iconColor: Theme.of(context).colorScheme.onPrimary,
                  widget: FittedBox(
                    child: Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.001),
                      child: Text(
                        'Cronômetro',
                        style: AppTextStyles.regularTextStyle(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                  ),
                  size: MediaQuery.of(context).size.width * 0.10,
                  borderColor: Theme.of(context).colorScheme.onPrimary,
                  borderWidth: 2,
                  onPressed:
                      () => showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return CustomBottomSheetWidget(
                            content: CustomStopwatchModalContentWidget(controller: timerController),
                          );
                        },
                      ),
                ),
                SizedBox(width: AppSpacing.medium(context)),
                CustomRectangleButtonWidget(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  iconColor: Theme.of(context).colorScheme.onPrimary,
                  widget: FittedBox(
                    child: Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.001),
                      child: Text(
                        'Countdown',
                        style: AppTextStyles.regularTextStyle(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                  ),
                  size: MediaQuery.of(context).size.width * 0.10,
                  borderColor: Theme.of(context).colorScheme.onPrimary,
                  borderWidth: 2,
                  onPressed:
                      () => showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return CustomCountdownModalContentWidget(controller: timerController);
                        },
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
