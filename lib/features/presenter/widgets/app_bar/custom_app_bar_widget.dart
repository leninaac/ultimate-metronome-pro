import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../main/themes/theme_controller.dart';
import '../styles/app_text_styles.dart';

enum AppBarType { centeredTitle, centeredTitleAndBackArrow }

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final AppBarType appBarType;
  final String title;
  final Function()? callback;

  const CustomAppBarWidget({super.key, required this.appBarType, required this.title, this.callback});
  void _cycleThemeMode(ThemeController controller) {
    final currentMode = controller.themeMode;
    ThemeMode newMode;
    switch (currentMode) {
      case ThemeMode.system:
        newMode = ThemeMode.light;
        break;
      case ThemeMode.light:
        newMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        newMode = ThemeMode.system;
        break;
    }
    controller.setThemeMode(newMode);
  }

  Widget _buildThemeToggle(BuildContext context) {
    final themeController = Modular.get<ThemeController>();
    final iconColor = Theme.of(context).colorScheme.onPrimary;

    return Observer(
      builder: (_) {
        final currentMode = themeController.themeMode;
        IconData icon;
        String tooltipText;

        switch (currentMode) {
          case ThemeMode.light:
            icon = Icons.light_mode_outlined;
            tooltipText = 'Modo Claro (Clique para Escuro)';
            break;
          case ThemeMode.dark:
            icon = Icons.dark_mode_outlined;
            tooltipText = 'Modo Escuro (Clique para Sistema)';
            break;
          case ThemeMode.system:
            icon = Icons.settings_brightness;
            tooltipText = 'Modo Sistema (Clique para Claro)';
            break;
        }

        return IconButton(
          icon: Icon(icon, color: iconColor),
          tooltip: tooltipText,
          onPressed: () => _cycleThemeMode(themeController),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    switch (appBarType) {
      case AppBarType.centeredTitle:
        return AppBar(
          backgroundColor: primaryColor,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          leading: Icon(Icons.menu, color: onPrimaryColor),

          title: Text(
              title,
              style: AppTextStyles.appBarTitleTextStyle(color: onPrimaryColor)
          ),
          centerTitle: true,
          actions: [
            _buildThemeToggle(context),
          ],
        );

      case AppBarType.centeredTitleAndBackArrow:
        return AppBar(
          backgroundColor: primaryColor,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: callback,
                child: Row(children: [Icon(Icons.arrow_back_ios, size: 19, color: onPrimaryColor)]),
              ),
              const SizedBox(width: 8),
              Text(title, style: AppTextStyles.appBarTitleTextStyle(color: onPrimaryColor)),
            ],
          ),
          actions: [
            _buildThemeToggle(context),
          ],
        );
    }
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
