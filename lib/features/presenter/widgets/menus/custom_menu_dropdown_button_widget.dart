import 'package:flutter/material.dart';
import 'package:ultimate_metronome_pro/design_system/colors/app_colors.dart';

class CustomMenuDropdownButtonWidget extends StatefulWidget {
  final List<Widget> menuItems;
  const CustomMenuDropdownButtonWidget({super.key, required this.menuItems});

  @override
  State<CustomMenuDropdownButtonWidget> createState() => _CustomMenuDropdownButtonWidgetState();
}

class _CustomMenuDropdownButtonWidgetState extends State<CustomMenuDropdownButtonWidget> {
  final MenuController _menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: MenuStyle(backgroundColor: WidgetStateProperty.all(AppColors.darkCharcoalLightColor)),
      alignmentOffset: Offset(16, 16),
      controller: _menuController,
      menuChildren: widget.menuItems,
      child: IconButton(
        icon: Icon(Icons.access_time_rounded, color: Colors.white),
        onPressed: () {
          if (_menuController.isOpen) {
            _menuController.close();
          } else {
            _menuController.open();
          }
        },
      ),
    );
  }
}
