import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ultimate_metronome_pro/core/identify_platform/identify_platform.dart';

import 'app_module.dart';
import 'app_widget.dart';
import 'features/presenter/widgets/errors/flutter_error_widget.dart';

void main() async {


  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    runApp(FlutterErrorWidget(details));
  };

  WidgetsFlutterBinding.ensureInitialized();

  await IdentifyPlatform.identifyOperatingSystem();

  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
