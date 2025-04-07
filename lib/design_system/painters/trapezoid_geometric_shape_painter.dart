import 'package:flutter/material.dart';

class TrapezoidGeometricShapePainter extends CustomPainter {
  final double topWidth;
  final double bottomWidth;
  final double height;
  final double position;

  TrapezoidGeometricShapePainter({
    required this.topWidth,
    required this.bottomWidth,
    required this.height,
    required this.position,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white;
    final path = Path()
      ..moveTo((size.width - topWidth) / 2, (position - height) / 2)
      ..lineTo(size.width + topWidth / 2, (position - height) / 2)
      ..lineTo(size.width + bottomWidth / 2, (position + height) / 2)
      ..lineTo((size.width - bottomWidth) / 2, (position + height) / 2)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}