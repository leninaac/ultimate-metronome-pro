import 'package:flutter/material.dart';

import '../../../../design_system/painters/app_geometric_shapes_painter.dart';

class PaintPendulumWidget extends StatelessWidget {
  final CustomPainter? foregroundPainter;

  const PaintPendulumWidget({super.key, this.foregroundPainter});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomPaint(
            painter: AppGeometricShapesPainter.createVerticalLine(lineWidth: 5, lineHeight: 100),
            foregroundPainter: foregroundPainter,
            child: Column(
              children: [
                Expanded(
                  child: CustomPaint(
                    painter: AppGeometricShapesPainter.createCircleCenter(radius: 10),
                  ),
                ),
                Expanded(
                  child: CustomPaint(
                    painter: AppGeometricShapesPainter.createCircleBottom(radius: 40),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
