import 'package:flutter/material.dart';

class CustomListWheelScrollViewWidget extends StatelessWidget {
  final FixedExtentScrollController controller;
  final List<int> items;
  final Function(int) onSelectedItemChanged;

  const CustomListWheelScrollViewWidget({
    super.key,
    required this.controller,
    required this.onSelectedItemChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: 30,
      physics: FixedExtentScrollPhysics(),
      diameterRatio: 1.0,
      onSelectedItemChanged: (index) => onSelectedItemChanged(index),
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, index) {
          if (index < items.length) {
            return Center(child: Text('${items[index]}', style: TextStyle(fontSize: 20)));
          }
          return null;
        },
        childCount: items.length,
      ),
    );
  }
}
