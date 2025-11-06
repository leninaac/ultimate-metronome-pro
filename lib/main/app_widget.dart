import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_metronome_pro/main/themes/app_theme.dart';
import 'package:ultimate_metronome_pro/main/themes/theme_controller.dart';

import '../consts/audios/app_audios.dart';
import '../core/audio_player_service/audio_player_service.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {

  late final ThemeController themeController;

  @override
  void initState() {
    _initAudioService();

    themeController = Modular.get<ThemeController>();
    themeController.loadThemeMode();


    super.initState();
  }

  void _initAudioService() async {
    final audioService = Modular.get<AudioPlayerService>();
    final prefs = Modular.get<SharedPreferences>();

    final tick1 = prefs.getString('tick1_path')?.trim();
    final tick2 = prefs.getString('tick2_path')?.trim();

    final hasValidPaths = tick1 != null && tick1.isNotEmpty && tick2 != null && tick2.isNotEmpty;

    final resolvedTick1 = hasValidPaths ? tick1 : AppAudios.tick1Audio;
    final resolvedTick2 = hasValidPaths ? tick2 : AppAudios.tick2Audio;

    try {
      // O init agora chama startPlayer (configura lowLatency) e preloadSounds (define as fontes).
      await audioService.init(tick1Path: resolvedTick1, tick2Path: resolvedTick2);
    } catch (e) {
      debugPrint('Falha ao iniciar AudioPlayerService: $e');
    }
  }


  @override
  Widget build(BuildContext context) {

    return Observer(
      builder: (_) {
        return MaterialApp.router(
          title: 'Metrônomo',
          debugShowCheckedModeBanner: false,
          routerConfig: Modular.routerConfig,
          theme: AppThemes.lightTheme,
          // darkTheme: AppThemes.darkTheme,
          themeMode: themeController.themeMode,

          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', 'BR'),
            Locale('en', 'US'),
            Locale('es', 'ES'),
          ],
          locale: const Locale('pt', 'BR'),
        );
      }
    );
  }
}
