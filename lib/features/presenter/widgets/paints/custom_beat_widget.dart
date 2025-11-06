import 'package:flutter/material.dart';

class CustomBeatWidget extends StatelessWidget {
  final double size;
  final bool filled;
  final Color color;
  final double strokeWidth;

  const CustomBeatWidget({
    super.key,
    this.size = 50.0,
    this.filled = true,
    this.color = Colors.blue,
    this.strokeWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? color : Colors.transparent,
        border: filled ? null : Border.all(color: color, width: strokeWidth),
      ),
    );
  }
}
