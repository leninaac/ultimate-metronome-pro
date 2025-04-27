import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

class AlarmNotifier {
  static const MethodChannel platform = MethodChannel("br.com.lenin.canuto.ultimateMetronomePro");

  static Future<void> showMacOsNotification(String title, String body) async {
    debugPrint("Tentando chamar o método showNotification no canal (macOS)!");
    try {
      await platform.invokeMethod('showNotification', {
        'title': title,
        'body': body,
        'platform': 'macOS', // Adicionando identificador de plataforma, se necessário
      });
      debugPrint("Notificação macOS chamada com sucesso!");
    } on PlatformException catch (e) {
      debugPrint("Erro ao exibir notificação (macOS): ${e.message}");
    }
  }

  static Future<void> showIosNotification(String title, String body) async {
    debugPrint("Tentando chamar o método showNotification no canal (iOS)!");
    try {
      await platform.invokeMethod('showNotification', {
        'title': title,
        'body': body,
        'platform': 'iOS', // Adicionando identificador de plataforma, se necessário
      });
      debugPrint("Notificação iOS chamada com sucesso!");
    } on PlatformException catch (e) {
      debugPrint("Erro ao exibir notificação (iOS): ${e.message}");
    }
  }

  static Future<void> showAndroidNotification(String title, String body) async {
    debugPrint("Tentando chamar o método showNotification no canal (Android)!");
    try {
      await platform.invokeMethod('showNotification', {
        'title': title,
        'body': body,
        'platform': 'Android', // Adicionando identificador de plataforma, se necessário
      });
      debugPrint("Notificação Android chamada com sucesso!");
    } on PlatformException catch (e) {
      debugPrint("Erro ao exibir notificação (Android): ${e.message}");
    }
  }

  // static Future<bool> requestNotificationPermission() async {
  //   if (!Platform.isAndroid) {
  //
  //     debugPrint("Solicitação de permissão de notificação chamada em plataforma não Android. Ignorando.");
  //     return true;
  //   }
  //
  //   debugPrint("Tentando chamar o metodo requestNotificationPermission no canal (Android)!");
  //   try {
  //     final bool? isGranted = await platform.invokeMethod('requestNotificationPermission');
  //     debugPrint("Resultado da solicitação de permissão (Android): $isGranted");
  //     return isGranted ?? false;
  //   } on PlatformException catch (e) {
  //     debugPrint("Erro ao solicitar permissão de notificação (Android): ${e.message}");
  //     return false;
  //   }
  // }

  static forPlatformSpecific(String title, String body){
    if(Platform.isMacOS) showMacOsNotification(title, body);
    if(Platform.isIOS) showIosNotification(title, body);
    if(Platform.isAndroid) showAndroidNotification(title, body);
  }
}