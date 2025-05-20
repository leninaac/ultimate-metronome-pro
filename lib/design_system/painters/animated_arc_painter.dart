import 'package:flutter/material.dart';
import 'dart:math' as math;
class AnimatedArcPainter extends CustomPainter {
  final double animatedSweepAngle;
  final Color baseArcColor;
  final Color animatedArcColor;
  final double strokeWidth;

  AnimatedArcPainter({
    required this.animatedSweepAngle,
    this.baseArcColor = Colors.blue,
    this.animatedArcColor = Colors.white,
    this.strokeWidth = 8,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final basePaint = Paint()
      ..color = baseArcColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final animatedPaint = Paint()
      ..color = animatedArcColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Offset.zero & size;

    const startAngle = 5 * math.pi / 6;
    const totalSweepAngle = 4 * math.pi / 3;

    canvas.drawArc(rect, startAngle, totalSweepAngle, false, basePaint);

    canvas.drawArc(rect, startAngle, animatedSweepAngle, false, animatedPaint);
  }

  @override
  bool shouldRepaint(covariant AnimatedArcPainter oldDelegate) {
    return oldDelegate.animatedSweepAngle != animatedSweepAngle;
  }
}