import 'dart:math';
import 'package:flutter/material.dart';

class CustomRingPainter extends CustomPainter {
  final double progress;         // 0.0 a 1.0 (Progress do Countdown)
  final double innerStrokeWidth;
  final double outerStrokeWidth;
  final double ringSpacing;
  final Color innerColor;
  final Color outerColor;
  final bool isWarningActive;    // Flag para ativar o glow
  final Color glowColor;
  final double pulseIntensity;   // 0.0 a 1.0 (Intensidade do pulso)

  CustomRingPainter({
    required this.progress,
    required this.innerStrokeWidth,
    required this.outerStrokeWidth,
    this.ringSpacing = 8.0,
    required this.innerColor,
    required this.outerColor,
    this.isWarningActive = false,
    this.glowColor = Colors.white,
    this.pulseIntensity = 0.0, // Inicia em 0
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center    = Offset(size.width/2, size.height/2);
    final maxRadius = min(size.width, size.height)/2;

    final outerRadius = maxRadius - outerStrokeWidth/2;
    final innerRadius = outerRadius
        - outerStrokeWidth/2
        - ringSpacing
        - innerStrokeWidth/2;

    // --- Efeito de Luminosidade (Glow) ---
    if (isWarningActive && pulseIntensity > 0.0) {
      // AUMENTADO: Multiplicador do desfoque para 4.0 (antes era 1.5)
      final baseBlur = outerStrokeWidth * 0.5;
      final blurSigma = baseBlur * pulseIntensity * 16.0;

      // AUMENTADO: Opacidade máxima para 0.8 (min 0.3, max 0.8)
      final glowPaintBase = Paint()
        ..style       = PaintingStyle.stroke
        ..color       = glowColor.withValues(alpha: 0.7 + (0.3 * pulseIntensity))
        ..maskFilter  = MaskFilter.blur(BlurStyle.normal, blurSigma)
        ..strokeCap   = StrokeCap.round;

      // 1. Glow para o Anel Interno (Sempre desenhado se o aviso estiver ativo)
      final glowPaintInner = Paint()
        ..style       = glowPaintBase.style
        ..color       = glowPaintBase.color
        ..maskFilter  = glowPaintBase.maskFilter
        ..strokeCap   = glowPaintBase.strokeCap
      // AUMENTADO: Largura do traço do glow para 5.0x (antes era 2.0x)
        ..strokeWidth = innerStrokeWidth * 16.0 * pulseIntensity;

      canvas.drawCircle(center, innerRadius, glowPaintInner);

      // 2. Glow para o Arco Externo (Desenha SOMENTE se houver progress, i.e., Countdown ativo)
      if (progress > 0.0) {
        final glowPaintOuter = Paint()
          ..style       = glowPaintBase.style
          ..color       = glowPaintBase.color
          ..maskFilter  = glowPaintBase.maskFilter
          ..strokeCap   = glowPaintBase.strokeCap
        // AUMENTADO: Largura do traço do glow para 5.0x (antes era 2.0x)
          ..strokeWidth = outerStrokeWidth * 16.0 * pulseIntensity;

        final rect = Rect.fromCircle(center: center, radius: outerRadius);
        final startAngle = -pi/2;
        final sweepAngle = 2 * pi * progress;
        canvas.drawArc(rect, startAngle, sweepAngle, false, glowPaintOuter);
      }
    }
    // ----------------------------------------------------

    // 3) Desenha o anel interno estático principal
    final innerPaint = Paint()
      ..style       = PaintingStyle.stroke
      ..strokeWidth = innerStrokeWidth
      ..color       = innerColor;
    canvas.drawCircle(center, innerRadius, innerPaint);

    // 4) Desenha o arco externo animado principal (SOMENTE se houver progress)
    if (progress > 0.0) {
      final outerPaint = Paint()
        ..style     = PaintingStyle.stroke
        ..strokeWidth = outerStrokeWidth
        ..color       = outerColor
        ..strokeCap   = StrokeCap.round;

      final rect       = Rect.fromCircle(center: center, radius: outerRadius);
      final startAngle = -pi/2;
      final sweepAngle = 2 * pi * progress;
      canvas.drawArc(rect, startAngle, sweepAngle, false, outerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomRingPainter old) =>
      old.progress         != progress ||
          old.innerStrokeWidth != innerStrokeWidth ||
          old.outerStrokeWidth != outerStrokeWidth ||
          old.ringSpacing      != ringSpacing      ||
          old.innerColor       != innerColor       ||
          old.outerColor       != outerColor       ||
          old.isWarningActive  != isWarningActive  ||
          old.glowColor        != glowColor        ||
          old.pulseIntensity   != pulseIntensity; // Repintar a cada pulso
}