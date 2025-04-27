import 'package:flutter/material.dart';

import 'custom_list_wheel_scroll_view_widget.dart';

class MultipleListWheelScrollViewWidget extends StatelessWidget {
  final List<Widget> wheels;
  const MultipleListWheelScrollViewWidget({super.key, required this.wheels});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: wheels,
    );
  }

  static MultipleListWheelScrollViewWidget twoWheelsWithSeparator({
    required FixedExtentScrollController firstController,
    required FixedExtentScrollController secondController,
    required List<int> firstItems,
    required List<int> secondItems,
    required Function(int) onFirstSelectedItemChanged,
    required Function(int) onSecondSelectedItemChanged,
    required String separator,
  }){
    return MultipleListWheelScrollViewWidget(
      wheels: [
        Expanded(
          child: CustomListWheelScrollViewWidget(
            controller: firstController,
            onSelectedItemChanged: onFirstSelectedItemChanged,
            items: firstItems,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(separator, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: CustomListWheelScrollViewWidget(
            controller: secondController,
            onSelectedItemChanged: onSecondSelectedItemChanged,
            items: secondItems,
          ),
        ),
      ],
    );
  }

  static MultipleListWheelScrollViewWidget threeWheelsWithSeparator({
    required FixedExtentScrollController firstController,
    required FixedExtentScrollController secondController,
    required FixedExtentScrollController thirdController,
    required List<int> firstItems,
    required List<int> secondItems,
    required List<int> thirdItems,
    required Function(int) onFirstSelectedItemChanged,
    required Function(int) onSecondSelectedItemChanged,
    required Function(int) onThirdSelectedItemChanged,
    required String firstSeparator,
    required String secondSeparator,
  }){
    return MultipleListWheelScrollViewWidget(
      wheels: [
        Expanded(
          child: CustomListWheelScrollViewWidget(
            controller: firstController,
            onSelectedItemChanged: onFirstSelectedItemChanged,
            items: firstItems,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(firstSeparator, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: CustomListWheelScrollViewWidget(
            controller: secondController,
            onSelectedItemChanged: onSecondSelectedItemChanged,
            items: secondItems,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(secondSeparator, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: CustomListWheelScrollViewWidget(
            controller: thirdController,
            onSelectedItemChanged: onThirdSelectedItemChanged,
            items: thirdItems,
          ),
        ),
      ],
    );
  }
}
