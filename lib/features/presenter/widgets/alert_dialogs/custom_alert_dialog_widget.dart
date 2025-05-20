import 'package:flutter/material.dart';

import '../../../../design_system/colors/app_colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      backgroundColor: AppColors.darkCharcoalColor,
      title: Text(title, style: TextStyle(color: Colors.white)),
      content: SizedBox(
        height: 200,
        width: 400,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.darkCharcoalLightColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: AppColors.darkCharcoalDeepColor,
              width: 2,
            ),
          ),
          child: content,
        ),
      ),
      actions: actions,
    );
  }
}
