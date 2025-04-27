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

  static forPlatformSpecific(String title, String body){
    if(Platform.isMacOS) showMacOsNotification(title, body);
    if(Platform.isIOS) showIosNotification(title, body);
  }
}