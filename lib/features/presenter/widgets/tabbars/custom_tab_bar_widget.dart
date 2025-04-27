import 'package:flutter/material.dart';

import '../../../../design_system/colors/app_colors.dart';

class CustomTabBarWidget extends StatefulWidget {
  final String title;
  final int tabLength;
  final Widget firstTabContent;

  final Widget secondTabContent;
  final Widget? thirdTabContent;
  final String firstTabTitle;
  final String secondTabTitle;
  final String? thirdTabTitle;

  const CustomTabBarWidget({
    super.key,
    required this.title,
    required this.tabLength,
    required this.firstTabContent,
    required this.secondTabContent,
    required this.firstTabTitle,
    required this.secondTabTitle,
    this.thirdTabTitle,
    this.thirdTabContent,
  });

  @override
  State<CustomTabBarWidget> createState() => _CustomTabBarWidgetState();
}

class _CustomTabBarWidgetState extends State<CustomTabBarWidget> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.tabLength, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          dividerColor: AppColors.darkCharcoalDeepColor,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerHeight: 2,
          controller: _tabController,
          tabs: [
            Tab(child: Text(widget.firstTabTitle, style: TextStyle(color: Colors.white))),
            Tab(child: Text(widget.secondTabTitle, style: TextStyle(color: Colors.white))),
          ],
          onTap: (index) {
            setState(() {
              _tabController?.index = index;
            });
          },
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              widget.firstTabContent,
              widget.secondTabContent,
            ],
          ),
        ),
      ],
    );
  }
}
