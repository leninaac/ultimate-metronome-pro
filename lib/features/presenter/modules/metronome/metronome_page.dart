import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/metronome/metronome_controller.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/tabbars/custom_tab_bar_widget.dart';

import '../../../../design_system/colors/app_colors.dart';
import '../../../../design_system/painters/circle_stroke_geometric_shape_painter.dart';
import '../../../../design_system/typography/app_fonts.dart';
import '../../widgets/alert_dialogs/custom_alert_dialog_widget.dart';

class MetronomePage extends StatefulWidget {
  const MetronomePage({super.key});

  @override
  State<MetronomePage> createState() => _MetronomePageState();
}

class _MetronomePageState extends State<MetronomePage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<MetronomeController>();
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
      initialItem: [1, 2, 4, 8,].indexOf(controller.denominator), // Busca o índice do denominador na lista
    );

    final FixedExtentScrollController subdivisonController = FixedExtentScrollController(
      initialItem: [1, 2, 4, 8,].indexOf(controller.subdivision), // Busca o índice do denominador na lista
    );

    final FocusNode focusNode = FocusNode();
    final TextEditingController bpmController = TextEditingController(
      text: controller.bpm.toString(),
    );

    return Scaffold(
      backgroundColor: AppColors.darkCharcoalColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: paddingVertical,
                right: paddingHorizontal,
                left: paddingHorizontal,
              ),
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
              padding: EdgeInsets.only(
                top: paddingVertical,
                right: paddingHorizontal,
                left: paddingHorizontal,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed:
                        () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlertDialog.twoItensInARow(
                              title: 'Escolha Valores',
                              separator: '/',
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text("Fechar", style: TextStyle(color: Colors.white)),
                                ),
                              ],
                              firstNumeratorController: numeratorController,
                              secondNumeratorController: denominatorController,
                              onFirstSelectedItemChanged: (index) {
                                controller.setNumerator(index + 1);

                                debugPrint("Item atual da primeira coluna: ${index + 1}");
                              },
                              onSecondSelectedItemChanged: (index){
                                final values = [1, 2, 4, 8];
                                controller.setDenominator(values[index]);

                                debugPrint("Item atual da segunda coluna: $index");
                              },
                              firstChildDelegate: ListWheelChildBuilderDelegate(
                                builder: (context, index) {
                                  if (index < 16) {
                                    return Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }
                                  return null;
                                },
                                childCount: 16,
                              ),
                              secondChildDelegate: ListWheelChildBuilderDelegate(
                                  builder: (context, index){
                                    final values = [1, 2, 4, 8];
                                    if(index < values.length){
                                      return Center(
                                        child: Text(
                                          '${values[index]}',
                                          style: TextStyle(
                                            fontSize: 20, // Tamanho maior para destaque
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    }
                                    return null;
                                  },
                                childCount: 4,
                              ),
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
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertDialog.oneItensInARow(
                            title: 'Subdivisão',
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("Pronto", style: TextStyle(color: Colors.white)),
                              ),
                            ],
                            numeratorController: subdivisonController,
                            onSelectedItemChanged: (index){
                              final values = [1, 2, 4, 8];
                              controller.setSubdivision(values[index]);

                              debugPrint("Item atual da subdivisão: $index");
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder: (context, index){
                                final values = [1, 2, 4, 8];
                                if(index < values.length){
                                  return Center(
                                    child: Text(
                                      '${values[index]}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }
                                return null;
                              },
                              childCount: 4,
                            ),
                        );
                      }
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
              padding: EdgeInsets.only(
                top: paddingVertical,
                left: paddingHorizontal,
                right: paddingHorizontal,
              ),
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
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: screenWidth * 0.03,
                            ),
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
              padding: EdgeInsets.only(
                top: paddingVertical,
                left: paddingHorizontal,
                right: paddingHorizontal,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.timer_outlined, color: Colors.white, size: screenWidth * 0.1),
                    onPressed: () => showDialog(
                        context: context,
                      builder: (BuildContext context) {
                          return CustomAlertDialog(
                              title: 'Cronômetro',
                              content: CustomTabBarWidget(
                                tabController: TabController(length: 2, vsync: this, initialIndex: 0),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text("Pronto", style: TextStyle(color: Colors.white)),
                                ),
                              ],
                          );
                      }),
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
