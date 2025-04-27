import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class IdentifyPlatform {
  IdentifyPlatform._();

  static identifyOperatingSystem() {
    if(Platform.isAndroid) {
      debugPrint('Identificado sistema Operacional Android');
    } else if(Platform.isIOS) {
      debugPrint('Identificado sistema Operacional IOS');
    }else if(Platform.isWindows) {
      debugPrint('Identificado sistema Operacional Windows');
    }else if(Platform.isLinux) {
      debugPrint('Identificado sistema Operacional Linux');
    }else if(Platform.isMacOS) {
      debugPrint('Identificado sistema Operacional MacOS');
    } else {
      debugPrint('Sistema Operacional não identificado');
    }
  }
}