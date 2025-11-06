import 'package:flutter/material.dart';

class BpmInputFormatter {
  final int minBpm;
  final int maxBpm;
  final int defaultBpm;

  const BpmInputFormatter({
    this.minBpm = 20,
    this.maxBpm = 400,
    this.defaultBpm = 120,
  });

  String correctInput(String input) {
    if (input.isEmpty) {
      return defaultBpm.toString();
    }

    final int? parsedBpm = int.tryParse(input);

    if (parsedBpm == null) {
      return defaultBpm.toString();
    }

    final int correctedBpm = parsedBpm.clamp(minBpm, maxBpm);
    return correctedBpm.toString();
  }

  void applyCorrection(TextEditingController controller) {
    final String currentText = controller.text;
    final String correctedText = correctInput(currentText);

    if (currentText != correctedText) {
      
      controller.value = controller.value.copyWith(
        text: correctedText,
        selection: TextSelection.collapsed(offset: correctedText.length),
        composing: TextRange.empty,
      );
    }
  }
}