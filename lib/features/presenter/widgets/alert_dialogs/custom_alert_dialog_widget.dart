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
        height: 80,
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

  factory CustomAlertDialog.oneItensInARow({
    Key? key,
    required String title,
    required List<Widget> actions,
    required FixedExtentScrollController numeratorController,
    required Function(int index) onSelectedItemChanged,
    required ListWheelChildDelegate childDelegate,
  }) {
    return CustomAlertDialog(
      key: key,
      title: title,
      content: SizedBox(
        height: 80,
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
          child: Row(
            children: [
              // Primeira coluna com números de 1 a 16
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  controller: numeratorController,
                  itemExtent: 30,
                  // Altura de cada item
                  physics: FixedExtentScrollPhysics(),
                  // Mantém o efeito de rolagem fixa
                  diameterRatio: 1.0,
                  // Controla o "efeito de perspectiva"
                  onSelectedItemChanged: onSelectedItemChanged,
                  childDelegate: childDelegate,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: actions,
    );
  }

  factory CustomAlertDialog.twoItensInARow({
    Key? key,
    required String title,
    required String separator,
    required List<Widget> actions,
    required FixedExtentScrollController firstNumeratorController,
    required FixedExtentScrollController secondNumeratorController,
    required Function(int index) onFirstSelectedItemChanged,
    required Function(int index) onSecondSelectedItemChanged,
    required ListWheelChildDelegate firstChildDelegate,
    required ListWheelChildDelegate secondChildDelegate,
  }) {
    return CustomAlertDialog(
      key: key,
      title: title,
      content: SizedBox(
        height: 80,
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
          child: Row(
            children: [
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  controller: firstNumeratorController,
                  itemExtent: 30,
                  // Altura de cada item
                  physics: FixedExtentScrollPhysics(),
                  // Mantém o efeito de rolagem fixa
                  diameterRatio: 1.0,
                  // Controla o "efeito de perspectiva"
                  onSelectedItemChanged: onFirstSelectedItemChanged,
                  childDelegate: firstChildDelegate,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  separator,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  controller: secondNumeratorController,
                  itemExtent: 30,
                  physics: FixedExtentScrollPhysics(),
                  diameterRatio: 1.0,
                  onSelectedItemChanged: onSecondSelectedItemChanged,
                  childDelegate: secondChildDelegate,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: actions,
    );
  }



}
