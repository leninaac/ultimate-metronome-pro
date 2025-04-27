import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ultimate_metronome_pro/consts/musical_signatures/app_musical_signatures.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/metronome/metronome_controller.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/list_wheel_scroll_view/multiple_list_wheel_scroll_view_widget.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/tabbars/custom_tab_bar_widget.dart';

import '../../../../consts/musical_signatures/time_signatures/app_time_signatures.dart';
import '../../../../design_system/colors/app_colors.dart';
import '../../../../design_system/painters/circle_stroke_geometric_shape_painter.dart';
import '../../../../design_system/typography/app_fonts.dart';
import '../../widgets/alert_dialogs/custom_alert_dialog_widget.dart';
import '../../widgets/list_wheel_scroll_view/custom_list_wheel_scroll_view_widget.dart';
import '../timer/timer_controller.dart';

class MetronomePage extends StatelessWidget {
  const MetronomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<MetronomeController>();
    final timerController = Modular.get<TimerController>();
    controller.preloadAudio();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculando os 15% para o padding
    double paddingHorizontal = screenWidth * 0.08;
    double paddingVertical = screenHeight * 0.08;

    final FixedExtentScrollController numeratorController = FixedExtentScrollController(
      initialItem: controller.numerator - 1,
    ); // Subtraímos 1 porque o índice começa em 0

    final FixedExtentScrollController denominatorController = FixedExtentScrollController(
      initialItem: AppMusicalSignatures.kAppDenominatorMusicalSignature.indexOf(controller.denominator),
    );

    final FixedExtentScrollController subdivisonController = FixedExtentScrollController(
      initialItem: [1, 2, 4, 8].indexOf(controller.subdivision), // Busca o índice do denominador na lista
    );

    final FixedExtentScrollController hourController = FixedExtentScrollController(
      initialItem: List.generate(23, (index) => index + 1).indexOf(timerController.stopwatchHours),
    );

    final FixedExtentScrollController minutesController = FixedExtentScrollController(
      initialItem: List.generate(60, (index) => index).indexOf(timerController.stopwatchMinutes),
    );

    final FixedExtentScrollController secondsController = FixedExtentScrollController(
      initialItem: List.generate(60, (index) => index).indexOf(timerController.stopwatchSeconds),
    );

    final FocusNode focusNode = FocusNode();
    final TextEditingController bpmController = TextEditingController(text: controller.bpm.toString());

    return Scaffold(
      backgroundColor: AppColors.darkCharcoalColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: paddingVertical, right: paddingHorizontal, left: paddingHorizontal),
              child: Observer(
                builder: (context) {
                  // Calcula o tamanho do ícone com base na largura disponível
                  double iconSize = (screenWidth * 0.5) / controller.numerator;

                  // Garante um tamanho mínimo e máximo para os ícones
                  if (iconSize > screenWidth * 0.1) {
                    iconSize = screenWidth * 0.1; // Tamanho máximo
                  } else if (iconSize < 20) {
                    iconSize = 20; // Tamanho mínimo
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(controller.numerator, (index) {
                      return Icon(
                        index + 1 == controller.visualTickPosition && controller.metronomeIsRunning
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: Colors.white,
                        size: iconSize,
                      );
                    }),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: paddingVertical, right: paddingHorizontal, left: paddingHorizontal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed:
                        () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlertDialog(
                              title: 'Escolha Valores',
                              content: MultipleListWheelScrollViewWidget.twoWheelsWithSeparator(
                                firstController: numeratorController,
                                secondController: denominatorController,
                                firstItems: AppMusicalSignatures.kAppNumeratorMusicalSignature,
                                secondItems: AppMusicalSignatures.kAppDenominatorMusicalSignature,
                                onFirstSelectedItemChanged: (index) {
                                  controller.setNumerator(AppMusicalSignatures.kAppNumeratorMusicalSignature[index]);
                                  debugPrint("Item atual da primeira coluna: ${controller.numerator}");
                                },
                                onSecondSelectedItemChanged: (index) {
                                  controller.setDenominator(
                                    AppMusicalSignatures.kAppDenominatorMusicalSignature[index],
                                  );
                                  debugPrint("Item atual da segunda coluna: ${controller.denominator}");
                                },
                                separator: '/',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text("Fechar", style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            );
                          },
                        ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Bordas arredondadas de 5
                      ),
                      side: BorderSide(color: Colors.white, width: screenWidth * 0.005),
                      minimumSize: Size(screenWidth * 0.15, screenWidth * 0.15),
                      // Define largura e altura iguais
                      padding: EdgeInsets.zero, // Remove o preenchimento adicional
                    ),
                    child: Observer(
                      builder: (context) {
                        return Text(
                          controller.timeSignature, // Exibe a sigla BPM
                          style: TextStyle(
                            fontFamily: AppFonts.modernSansFont,
                            fontSize: screenWidth * 0.07, // Tamanho do texto
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  OutlinedButton(
                    onPressed:
                        () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlertDialog(
                              title: 'Subdivisão',
                              content: CustomListWheelScrollViewWidget(
                                controller: subdivisonController,
                                onSelectedItemChanged: (index) {
                                  controller.setSubdivision(
                                    AppMusicalSignatures.kAppSubdivisionMusicalSignature[index],
                                  );
                                  debugPrint("Item atual da subdivisão: ${controller.subdivision}");
                                },
                                items: AppMusicalSignatures.kAppSubdivisionMusicalSignature,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text("Fechar", style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            );
                          },
                        ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Bordas arredondadas de 5
                      ),
                      side: BorderSide(color: Colors.white, width: screenWidth * 0.005),
                      minimumSize: Size(screenWidth * 0.15, screenWidth * 0.15),
                      // Define largura e altura iguais
                      padding: EdgeInsets.zero, // Remove o preenchimento adicional
                    ),
                    child: Text(
                      'º|', // Exibe a sigla BPM
                      style: TextStyle(
                        fontFamily: AppFonts.modernSansFont,
                        fontSize: screenWidth * 0.07, // Tamanho do texto
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: paddingVertical, left: paddingHorizontal, right: paddingHorizontal),
              child: GestureDetector(
                onTap: () {
                  focusNode.requestFocus();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      painter: CircleStrokeGeometricShapePainter(
                        lineColor: Colors.white,
                        strokeWidth: screenWidth * 0.005,
                      ),
                      size: Size(screenWidth * 0.4, screenWidth * 0.4),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Observer(
                          builder:
                              (context) => Text(
                                '${controller.bpm}'.toUpperCase(), // Exibe o valor do BPM
                                style: TextStyle(
                                  fontFamily: AppFonts.modernSansFont,
                                  fontSize: screenWidth * 0.15, // Tamanho do texto
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                        ),

                        Text(
                          'BPM', // Exibe a sigla BPM
                          style: TextStyle(
                            fontFamily: AppFonts.modernSansFont,
                            fontSize: screenWidth * 0.07, // Tamanho do texto
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      controller: bpmController,
                      focusNode: focusNode,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 0, height: 0),
                      decoration: InputDecoration.collapsed(hintText: null),
                      onChanged: (value) {
                        int? newBpm = int.tryParse(value);
                        newBpm ?? newBpm;

                        (newBpm != null && newBpm > 400) ? newBpm = 400 : newBpm;

                        (newBpm != null && newBpm <= 0) ? newBpm = 0 : newBpm;

                        if (newBpm != null) {
                          controller.setBpm(newBpm);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(paddingHorizontal),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      controller.setBpm(controller.bpm - 1);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: CircleBorder(),
                      side: BorderSide(color: Colors.white, width: screenWidth * 0.005),
                      padding: EdgeInsets.all(screenWidth * 0.02),
                    ),
                    child: Icon(Icons.remove, color: Colors.white, size: screenWidth * 0.1),
                  ),

                  Observer(
                    builder: (context) {
                      return Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.black,
                            inactiveTrackColor: Colors.white,
                            thumbColor: Colors.black,
                            activeTickMarkColor: AppColors.darkCharcoalColor,
                            // Divisores à esquerda do thumb
                            inactiveTickMarkColor: Colors.white,
                            // Divisores à direita do thumb
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: screenWidth * 0.03),
                            trackShape: RoundedRectSliderTrackShape(),
                            trackHeight: screenWidth * 0.01,
                          ),
                          child: Slider(
                            min: 20,
                            max: 300,
                            divisions: 56,
                            value: controller.sliderValue,
                            onChanged: (double value) {
                              controller.setBpm(value.toInt());
                            },
                          ),
                        ),
                      );
                    },
                  ),

                  OutlinedButton(
                    onPressed: () {
                      controller.setBpm(controller.bpm + 1);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: CircleBorder(),
                      side: BorderSide(color: Colors.white, width: screenWidth * 0.005),
                      padding: EdgeInsets.all(screenWidth * 0.02),
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: screenWidth * 0.1),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      controller.startMetronome();
                    },
                    style: OutlinedButton.styleFrom(
                      shape: CircleBorder(),
                      side: BorderSide(color: Colors.white, width: screenWidth * 0.005),
                      padding: EdgeInsets.all(screenWidth * 0.02),
                    ),
                    child: Icon(Icons.play_arrow, color: Colors.white, size: screenWidth * 0.1),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      controller.stopMetronome();
                    },
                    style: OutlinedButton.styleFrom(
                      shape: CircleBorder(),
                      side: BorderSide(color: Colors.white, width: screenWidth * 0.005),
                      padding: EdgeInsets.all(screenWidth * 0.02),
                    ),
                    child: Icon(Icons.stop, color: Colors.white, size: screenWidth * 0.1),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: paddingVertical, left: paddingHorizontal, right: paddingHorizontal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.timer_outlined, color: Colors.white, size: screenWidth * 0.1),
                    onPressed:
                        () => showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return CustomBottomSheetWidget(
                              content: CustomTabBarWidget(
                                title: 'Cronômetro',
                                tabLength: 2,
                                firstTabTitle: 'Cronômetro',
                                secondTabTitle: 'Timer',
                                firstTabContent: Padding(
                                  padding: EdgeInsets.only(top: paddingHorizontal, left: paddingHorizontal, right: paddingHorizontal),
                                  child: Column(
                                    children: [
                                      Observer(
                                        builder: (context) {
                                          return SizedBox(
                                            width: screenWidth,
                                            child: Text(
                                              '${timerController.stopwatchMinutes.toString().padLeft(2, '0')}:${timerController.stopwatchSeconds.toString().padLeft(2, '0')},${(timerController.milliseconds ~/ 10).toString().padLeft(2, '0')}',
                                              style: TextStyle(
                                                fontFamily: AppFonts.modernSansFont,
                                                fontSize: screenWidth * 0.15, // Tamanho do texto
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                timerController.resetStopwatch();
                                              },
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                minimumSize: Size(screenWidth * 0.15, screenWidth * 0.15),
                                                padding: EdgeInsets.zero,
                                              ),
                                              child: Icon(Icons.stop, color: Colors.white, size: screenWidth * 0.1),
                                            ),
                                          ),
                                          SizedBox(width: paddingHorizontal),
                                          Expanded(
                                            child: Observer(
                                              builder: (context) {
                                                return ElevatedButton(
                                                  onPressed: () {
                                                    if (!timerController.isStopwatchRunning) {
                                                      timerController.startStopwatch();
                                                    } else {
                                                      timerController.pauseStopwatch();
                                                    }
                                                  },
                                                  style: OutlinedButton.styleFrom(
                                                    backgroundColor: Colors.black,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(
                                                        5,
                                                      ),
                                                    ),
                                                    minimumSize: Size(screenWidth * 0.15, screenWidth * 0.15),
                                                    padding: EdgeInsets.zero,
                                                  ),
                                                  child: Icon(
                                                    !timerController.isStopwatchRunning
                                                        ? Icons.play_arrow
                                                        : Icons.pause,
                                                    color: Colors.white,
                                                    size: screenWidth * 0.1,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                secondTabContent: Padding(
                                  padding: EdgeInsets.all(paddingHorizontal),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: MultipleListWheelScrollViewWidget.threeWheelsWithSeparator(
                                          firstController: hourController,
                                          secondController: minutesController,
                                          thirdController: secondsController,
                                          firstItems: AppTimeSignatures.kAppHourTimeSignature,
                                          secondItems: AppTimeSignatures.kAppMinutesTimeSignature,
                                          thirdItems: AppTimeSignatures.kAppSecondsTimeSignature,
                                          onFirstSelectedItemChanged: (index) {
                                            timerController.setCountdownHours(AppTimeSignatures.kAppHourTimeSignature[index]);
                                            debugPrint("Item atual da hora: ${timerController.countdownHours}");
                                          },
                                          onSecondSelectedItemChanged: (index) {
                                            timerController.setCountdownMinutes(
                                              AppTimeSignatures.kAppMinutesTimeSignature[index],
                                            );
                                            debugPrint("Item atual dos minutos: ${timerController.countdownMinutes}");
                                          },
                                          onThirdSelectedItemChanged: (index) {
                                            timerController.setCountdownSeconds(
                                              AppTimeSignatures.kAppSecondsTimeSignature[index],
                                            );
                                            debugPrint("Item atual dos segundos: ${timerController.countdownSeconds}");
                                          },
                                          firstSeparator: ':',
                                          secondSeparator: ':',
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                timerController.resetCountdownTimer();
                                              },
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5), // Bordas arredondadas de 5
                                                ),
                                                minimumSize: Size(screenWidth * 0.15, screenWidth * 0.15),
                                                // Define largura e altura iguais
                                                padding: EdgeInsets.zero, // Remove o preenchimento adicional
                                              ),
                                              child: Icon(Icons.stop, color: Colors.white, size: screenWidth * 0.1),
                                            ),
                                          ),
                                          SizedBox(width: paddingHorizontal),
                                          Expanded(
                                            child: Observer(
                                              builder: (context) {
                                                return ElevatedButton(
                                                  onPressed: () {
                                                    if (!timerController.isCountdownRunning) {
                                                      controller.startMetronome();
                                                      timerController.startCountdownTimer(controller);
                                                    } else {
                                                      controller.stopMetronome();
                                                      timerController.pauseCountdownTimer();
                                                    }
                                                    Navigator.pop(context);
                                                  },
                                                  style: OutlinedButton.styleFrom(
                                                    backgroundColor: Colors.black,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(
                                                        5,
                                                      ), // Bordas arredondadas de 5
                                                    ),
                                                    minimumSize: Size(screenWidth * 0.15, screenWidth * 0.15),
                                                    // Define largura e altura iguais
                                                    padding: EdgeInsets.zero, // Remove o preenchimento adicional
                                                  ),
                                                  child: Icon(
                                                    !timerController.isCountdownRunning
                                                        ? Icons.play_arrow
                                                        : Icons.pause,
                                                    color: Colors.white,
                                                    size: screenWidth * 0.1,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                  ),
                  Row(
                    children: [
                      Observer(
                        builder: (context) {
                          String timerStr = '00:00:00';
                          if(timerController.isCountdownRunning && !timerController.isStopwatchRunning) {
                            final hoursStr = timerController.countdownHours.toString().padLeft(2, '0');
                            final minutesStr = timerController.countdownMinutes.toString().padLeft(2, '0');
                            final secondsStr = timerController.countdownSeconds.toString().padLeft(2, '0');
                            timerStr = '$hoursStr:$minutesStr:$secondsStr';
                          } else  if(!timerController.isCountdownRunning && timerController.isStopwatchRunning) {
                            final hoursStr = timerController.stopwatchHours.toString().padLeft(2, '0');
                            final minutesStr = timerController.stopwatchMinutes.toString().padLeft(2, '0');
                            final secondsStr = timerController.stopwatchSeconds.toString().padLeft(2, '0');
                            timerStr = '$hoursStr:$minutesStr:$secondsStr';
                          }

                          return Text(
                            timerStr,
                            style: TextStyle(
                              fontFamily: AppFonts.modernSansFont,
                              fontSize: screenWidth * 0.07, // Tamanho do texto
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      SizedBox(width: paddingHorizontal),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Observer(
                            builder: (context) {
                              return IconButton(
                                icon: Icon(!timerController.isCountdownRunning
                                    ? Icons.play_arrow
                                    : Icons.pause, color: Colors.white, size: screenWidth * 0.1),
                                onPressed: () {
                                  if (!timerController.isCountdownRunning) {
                                    controller.startMetronome();
                                    timerController.startCountdownTimer(controller);
                                  } else {
                                    timerController.pauseCountdownTimer();
                                    controller.stopMetronome();
                                  }
                                }
                              );
                            }
                          ),
                          IconButton(
                            icon: Icon(Icons.stop, color: Colors.white, size: screenWidth * 0.1),
                            onPressed: () => timerController.resetCountdownTimer(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
