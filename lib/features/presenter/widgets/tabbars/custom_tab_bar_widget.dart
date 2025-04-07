import 'package:flutter/material.dart';

class CustomTabBarWidget extends StatefulWidget  {
  final TabController? tabController;
  const CustomTabBarWidget({super.key, this.tabController});

  @override
  State<CustomTabBarWidget> createState() => _CustomTabBarWidgetState();
}

class _CustomTabBarWidgetState extends State<CustomTabBarWidget> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TabBar(
              controller: widget.tabController,
              tabs: const [
                Text('Indefinido'),
                Text('Definido'),
                ],
            ),
            Text('Conteúdo'),
          ],
        ),
      ],
    );
  }
}
