import 'package:flutter/material.dart';

class CustomCircularButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final Widget icon;
  final double size;
  final VoidCallback onPressed;
  final Color borderColor;
  final double borderWidth;

  const CustomCircularButtonWidget({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    required this.icon,
    required this.size,
    required this.onPressed,
    required this.borderColor,
    required this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    // Wrap with SizedBox to constrain the hit area of the InkWell
    return SizedBox(
      width: size,
      height: size,
      child: InkWell(
        customBorder: const CircleBorder(), // Use CircleBorder for a circular ripple effect
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          child: Center(
            child: IconTheme(data: IconThemeData(color: iconColor, size: size), child: icon),
          ),
        ),
      ),
    );
  }
}
