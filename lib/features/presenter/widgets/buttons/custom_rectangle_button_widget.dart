import 'package:flutter/material.dart';

class CustomRectangleButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final Widget widget;
  final double size;
  final VoidCallback onPressed;
  final Color borderColor;
  final double borderWidth;

  const CustomRectangleButtonWidget({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    required this.widget,
    required this.size,
    required this.onPressed,
    required this.borderColor,
    required this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular((size * 2 + 16) / 2),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Center(
          child: IconTheme(
            data: IconThemeData(color: iconColor, size: size),
            child: widget,
          ),
        ),
      )
    );
  }
}
