import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_metronome_pro/core/identify_platform/identify_platform.dart';
import 'package:ultimate_metronome_pro/firebase_options.dart';

import 'app_module.dart';
import 'app_widget.dart';
import '../features/presenter/widgets/errors/flutter_error_widget.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    runApp(FlutterErrorWidget(details));
  };
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final sharedPreferences = await SharedPreferences.getInstance();

  IdentifyPlatform.identifyOperatingSystem();

  runApp(ModularApp(module: AppModule(sharedPreferences: sharedPreferences), child: AppWidget()));
}
