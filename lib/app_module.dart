import 'package:flutter_modular/flutter_modular.dart';
import 'package:ultimate_metronome_pro/consts/routes/app_routes.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/home/home_page.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/metronome/metronome_controller.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/metronome/metronome_page.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/timer/timer_controller.dart';


class AppModule extends Module {

  @override
void binds(Injector i) {

    ///METRONOME BINDS
    i.addLazySingleton<MetronomeController>(MetronomeController.new);

    ///COUNTDOWN BINDS
    i.addLazySingleton<TimerController>(TimerController.new);

    ///TAP TEMPO BINDS
  }

  @override
  void routes(RouteManager r) {
   r.child(AppRoutes.appDefaultRoute, child: (context) => MetronomePage());
   r.child(AppRoutes.appMetronomePageRoute, child: (context) => MetronomePage());
   r.child(AppRoutes.appHomePageRoute, child: (context) => HomePage(remainingTimeInSeconds: 5, initialBpm: 120,));
  }
}