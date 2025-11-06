import 'package:flutter/material.dart';

class AppBackgroundWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final bool scrollable;
  final Widget child;

  const AppBackgroundWidget({super.key, this.appBar, this.scrollable = false, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar,
      body: SafeArea(
        child: scrollable ? SingleChildScrollView(child: child) : child,
      ),
    );
  }
}
