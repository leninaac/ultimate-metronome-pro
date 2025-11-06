import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_metronome_pro/consts/routes/app_routes.dart';
import 'package:ultimate_metronome_pro/core/audio_player_service/audio_player_service_impl.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/home/home_page.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/metronome/metronome_controller.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/metronome/metronome_page.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/timer/timer_controller.dart';
import 'package:ultimate_metronome_pro/main/themes/theme_controller.dart';

import '../core/audio_player_service/audio_player_service.dart';
import '../core/local_storage/local_storage_client.dart';
import '../core/local_storage/local_storage_client_shared_prefs_impl.dart';
import '../design_system/strings/app_strings_portuguese.dart';


class AppModule extends Module {

  final SharedPreferences sharedPreferences;

  AppModule({required this.sharedPreferences});

  @override
void binds(Injector i) {

    ///STORAGES

    //LOCAL STORAGE BINDS
    i.addInstance<SharedPreferences>(sharedPreferences);
    i.addLazySingleton<LocalStorageClient>(
      LocalStorageClientSharedPrefsImpl.new,
      key: AppStringsPortuguese.storageTypeLocal,
    );

    ///AUDIO PLAYER SERVICE
    i.addLazySingleton<AudioPlayerService>(() => AudioPlayerServiceImpl());

    ///THEME CONTROLLER
    i.addLazySingleton<ThemeController>(ThemeController.new);

    ///METRONOME BINDS
    i.addLazySingleton<MetronomeController>(MetronomeController.new);

    ///COUNTDOWN BINDS
    i.addLazySingleton<TimerController>(TimerController.new);

    ///TAP TEMPO BINDS
  }

  @override
  void routes(RouteManager r) {
   r.child(AppRoutes.appDefaultRoute, child: (context) => HomePage());
   r.child(AppRoutes.appMetronomePageRoute, child: (context) => MetronomePage());
   r.child(AppRoutes.appHomePageRoute, child: (context) => HomePage());

  }
}