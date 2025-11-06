import 'package:flutter/material.dart';
import 'package:ultimate_metronome_pro/design_system/colors/app_colors.dart';

class BackgroundWidget extends StatelessWidget {

  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget child;
  const BackgroundWidget({
    super.key,
    this.appBar,
    this.floatingActionButton,
    required this.child,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      backgroundColor: AppColors.primaryDeepDarkColor,
      body: SafeArea(child: child),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
