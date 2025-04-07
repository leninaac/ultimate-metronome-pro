
import 'package:flutter/cupertino.dart';

class CircleStrokeGeometricShapePainter extends CustomPainter {
  final Color lineColor;
  final double strokeWidth;
  
  CircleStrokeGeometricShapePainter({
    required this.lineColor,
    required this.strokeWidth,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
  
}