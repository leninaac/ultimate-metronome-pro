import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class IdentifyPlatform {
  IdentifyPlatform._();

  static String identifyOperatingSystem() {
    if(Platform.isAndroid) {
      debugPrint('Identificado sistema Operacional Android');
      return 'Android';
    } else if(Platform.isIOS) {
      debugPrint('Identificado sistema Operacional IOS');
      return 'IOS';
    }else if(Platform.isWindows) {
      debugPrint('Identificado sistema Operacional Windows');
      return 'Windows';
    }else if(Platform.isLinux) {
      debugPrint('Identificado sistema Operacional Linux');
      return 'Linux';
    }else if(Platform.isMacOS) {
      debugPrint('Identificado sistema Operacional MacOS');
      return 'MacOS';
    } else {
      debugPrint('Sistema Operacional não identificado');
      return 'Sistema Operacional não identificado';
    }
  }
}