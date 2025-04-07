import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragUpdate: (details){
        debugPrint('clicou');
      },
      child: Column(
        children: [
          Expanded(child: Container())
        ],
      ),
    );
  }
}
