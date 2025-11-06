import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/metronome/metronome_controller.dart';
import 'package:ultimate_metronome_pro/features/presenter/widgets/modal_contents/custom_time_signature_modal_content_widget.dart';

import '../../../../design_system/colors/app_colors.dart';
import '../animations/custom_animation_glow_widget.dart';
import '../animations/custom_animation_progress_widget.dart';
import '../bottom_sheet/custom_bottom_sheet_widget.dart';
import '../styles/app_text_styles.dart';
import 'custom_ring_painter.dart';

class CustomCircleWidget extends StatelessWidget {
  final double size;
  final Duration duration;
  final Color innerColor;
  final Color outerColor;
  final int bpm;
  final String tempoLabel;
  final String musicalSignature;
  final bool showProgress;
  final bool isCountdownActive;
  final bool isBpmChangeWarning;
  final Function() bpmClicked;

  const CustomCircleWidget({
    super.key,
    required this.size,
    required this.duration,
    required this.bpm,
    required this.tempoLabel,
    required this.musicalSignature,
    required this.bpmClicked,
    this.innerColor = AppColors.neonCyan,
    this.outerColor = AppColors.neonCyan,
    this.showProgress = false,
    this.isCountdownActive = false,
    this.isBpmChangeWarning = false,
  });
  @override
  Widget build(BuildContext context) {
    // 1. DEFINIÇÃO DE TAMANHOS E ESPAÇAMENTOS INTERNOS BASEADOS NO DIÂMETRO (size)
    final double diameter = size;
    final double fontSizeBPM = diameter * 0.15;
    final double fontSizeTempo = diameter * 0.07;
    final double fontSizeSig = diameter * 0.05;

    // Espaçamentos Verticais
    final double spacingTop = diameter * 0.15;
    final double spacingSmall = diameter * 0.02;
    final double spacingMedium = diameter * 0.04;

    final outerStroke = diameter * 0.025; // 2.5% do diâmetro para o traço externo
    final innerStroke = diameter * 0.04;  // 4% do diâmetro para o traço interno
    final ringSpacing = diameter * 0.015; // 1.5% do diâmetro para o espaçamento entre anéis
    final Color glowColor = Theme.of(context).colorScheme.primary.withValues(alpha: 0.8);

    // ------------------------------------------------
    // ANIMAÇÃO 1: PROGRESSO DO COUNTDOWN (Controla progress)
    // ------------------------------------------------
    return CustomAnimationProgressWidget(
      duration: duration,
      autoStart: isCountdownActive,
      repeat: false,
      builder: (ctx, progress, controller) {
        // O progress do Countdown só é usado se o Countdown estiver ativo
        final currentProgress = isCountdownActive ? progress : 0.0;

        // ------------------------------------------------
        // ANIMAÇÃO 2: GLOW PULSANTE (Controla pulseIntensity)
        // ------------------------------------------------
        return CustomAnimationGlowWidget(
          isWarningActive: isBpmChangeWarning, // Flag de aviso
          builder: (ctx, pulseIntensity, glowController) {

            return SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: CustomRingPainter(
                  // Passamos 0.0 se o Countdown não estiver ativo (para não desenhar o arco externo principal)
                  progress: currentProgress,
                  innerStrokeWidth: innerStroke,
                  outerStrokeWidth: outerStroke,
                  ringSpacing: ringSpacing,
                  innerColor: innerColor,
                  outerColor: outerColor,
                  isWarningActive: isBpmChangeWarning,
                  glowColor: glowColor,
                  pulseIntensity: pulseIntensity, // <-- Novo valor de pulsação
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ESPAÇAMENTO: Usa o tamanho proporcional ao diâmetro
                      SizedBox(height: spacingTop),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: GestureDetector(
                          onTap: bpmClicked,
                          child: Text(
                            '$bpm BPM',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.titleTextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ).copyWith(
                              fontSize: fontSizeBPM, // Sobrescreve o tamanho da fonte
                            ),
                          ),
                        ),
                      ),
                      // ESPAÇAMENTO: Usa o tamanho proporcional ao diâmetro
                      SizedBox(height: spacingSmall),
                      FractionallySizedBox(
                        widthFactor: 0.8,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            tempoLabel,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.subTitleTextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ).copyWith(
                              fontSize: fontSizeTempo, // Sobrescreve o tamanho da fonte
                            ),
                          ),
                        ),
                      ),
                      // ESPAÇAMENTO: Usa o tamanho proporcional ao diâmetro
                      SizedBox(height: spacingMedium),
                      FractionallySizedBox(
                        widthFactor: 0.7,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: GestureDetector(
                            onTap: () => showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return CustomBottomSheetWidget(
                                    content: CustomTimeSignatureModalContentWidget(
                                      controller: Modular.get<MetronomeController>(),
                                    ));
                              },
                            ),
                            child: Text(
                              musicalSignature,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.regularTextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ).copyWith(
                                fontSize: fontSizeSig, // Sobrescreve o tamanho da fonte
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}