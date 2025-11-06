import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/local_storage/local_storage_client.dart';
import '../../core/local_storage/local_storage_item.dart';
import '../../design_system/strings/app_strings_portuguese.dart';

part 'theme_controller.g.dart';

class ThemeController = ThemeControllerAbstract with _$ThemeController;

abstract class ThemeControllerAbstract with Store {
  static const String themeModeKey = 'app_theme_mode';

  @observable
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  @action
  Future<void> setThemeMode(ThemeMode mode) async {
    final localStorageClient = Modular.get<LocalStorageClient>(
      key: AppStringsPortuguese.storageTypeLocal,
    );

    _themeMode = mode;
    await localStorageClient.writeData(
      LocalStorageItem(key: themeModeKey, value: mode.name),
    );
  }

  @action
  Future<void> loadThemeMode() async {
    final localStorageClient = Modular.get<LocalStorageClient>(
      key: AppStringsPortuguese.storageTypeLocal,
    );

    final storedMode = await localStorageClient.readData(themeModeKey);

    if (storedMode != null) {
      _themeMode = ThemeMode.values.firstWhere(
            (e) => e.name == storedMode,
        orElse: () => ThemeMode.system,
      );
    }
  }
}