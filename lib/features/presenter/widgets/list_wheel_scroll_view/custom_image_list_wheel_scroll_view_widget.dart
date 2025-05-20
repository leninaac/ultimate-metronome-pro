import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageListWheelScrollViewWidget extends StatelessWidget {
  final FixedExtentScrollController controller;
  final List<String> items;
  final Function(int) onSelectedItemChanged;

  const CustomImageListWheelScrollViewWidget({
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
            return SvgPicture.asset(items[index], colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn));
            // return Center(child: Text('${items[index]}', style: TextStyle(fontSize: 20)));
          }
          return null;
        },
        childCount: items.length,
      ),
    );
  }
}
