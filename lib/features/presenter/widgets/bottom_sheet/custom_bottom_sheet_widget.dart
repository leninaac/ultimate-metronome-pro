import 'package:flutter/material.dart';
import 'package:ultimate_metronome_pro/design_system/colors/app_colors.dart';

class CustomBottomSheetWidget extends StatelessWidget {
  final Widget content;

  const CustomBottomSheetWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
          decoration: BoxDecoration(color: AppColors.darkCharcoalColor, borderRadius: BorderRadius.circular(12)),
          child: content,
        ),
      ),
    );
  }
}
