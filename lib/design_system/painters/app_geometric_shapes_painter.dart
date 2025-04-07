import 'package:flutter/material.dart';

class AppGeometricShapesPainter {
  static CustomPainter createVerticalLine({
    required double lineWidth,
    required double lineHeight,
  }) {
    return _VerticalLinePainter(width: lineWidth);
  }

  static CustomPainter createCircleCenter({required double radius}) {
    return _CircleCenterPainter(radius: radius);
  }

  static CustomPainter createCircleBottom({required double radius}) {
    return _CircleBottomPainter(radius: radius);
  }

  static CustomPainter createTrapezoid({
    required double topWidth,
    required double bottomWidth,
    required double height,
    required double position,
  }) {
    return _TrapezoidPainter(
        topWidth: topWidth,
        bottomWidth: bottomWidth,
        height: height,
        position: position,
    );
  }
}

class _VerticalLinePainter extends CustomPainter {
  final double width;

  _VerticalLinePainter({required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
    Paint()
      ..color = Colors.white
      ..strokeWidth = width;

    final start = Offset(size.width / 2, 0);
    final end = Offset(size.width / 2, size.height);

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CircleCenterPainter extends CustomPainter {
  final double radius;

  _CircleCenterPainter({required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;


    final circleCenter = Offset(size.width / 2, size.height * 1.40);
    canvas.drawCircle(circleCenter, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CircleBottomPainter extends CustomPainter {
  final double radius;
  _CircleBottomPainter({required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final circleBottomCenter = Offset(size.width / 2, size.height);
    canvas.drawCircle(circleBottomCenter, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TrapezoidPainter extends CustomPainter {
  final double topWidth;
  final double bottomWidth;
  final double height;
  final double position;

  _TrapezoidPainter({
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

