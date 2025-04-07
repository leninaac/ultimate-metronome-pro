import 'package:flutter/material.dart';

import '../../../../design_system/painters/app_geometric_shapes_painter.dart';

class PaintTrapezoidWidget extends StatelessWidget  {
  final Function(DragUpdateDetails details)? onVerticalDragUpdate;
  final double? trapezoidPosition;

  const PaintTrapezoidWidget({super.key, this.onVerticalDragUpdate, this.trapezoidPosition});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: AppGeometricShapesPainter.createTrapezoid(
        topWidth: 70,
        bottomWidth: 100,
        height: 50,
        position: trapezoidPosition ?? 0,
      ),
    );
  }
}
