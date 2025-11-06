// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeController on ThemeControllerAbstract, Store {
  late final _$_themeModeAtom = Atom(
    name: 'ThemeControllerAbstract._themeMode',
    context: context,
  );

  @override
  ThemeMode get _themeMode {
    _$_themeModeAtom.reportRead();
    return super._themeMode;
  }

  @override
  set _themeMode(ThemeMode value) {
    _$_themeModeAtom.reportWrite(value, super._themeMode, () {
      super._themeMode = value;
    });
  }

  late final _$setThemeModeAsyncAction = AsyncAction(
    'ThemeControllerAbstract.setThemeMode',
    context: context,
  );

  @override
  Future<void> setThemeMode(ThemeMode mode) {
    return _$setThemeModeAsyncAction.run(() => super.setThemeMode(mode));
  }

  late final _$loadThemeModeAsyncAction = AsyncAction(
    'ThemeControllerAbstract.loadThemeMode',
    context: context,
  );

  @override
  Future<void> loadThemeMode() {
    return _$loadThemeModeAsyncAction.run(() => super.loadThemeMode());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
