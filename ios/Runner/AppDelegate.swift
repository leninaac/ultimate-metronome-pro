import UIKit
import Flutter
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Solicitar permissão para notificações no iOS ao iniciar o app
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
      if granted {
        print("Permissão para notificações concedida no iOS.")
      } else if let error = error {
        print("Erro ao solicitar permissão de notificação no iOS: \(error.localizedDescription)")
      }
    }

    // Registre o MethodChannel
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name: "br.com.lenin.canuto.ultimateMetronomePro", binaryMessenger: controller.binaryMessenger)

    methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      // Verifique qual metodo Flutter está chamando
      if call.method == "showNotification" {
        if let arguments = call.arguments as? [String: Any],
           let title = arguments["title"] as? String,
           let body = arguments["body"] as? String {
          // Assumindo que esta chamada é sempre para iOS neste AppDelegate
          self.showNativeIosNotification(title: title, body: body)
          result(nil) // Indica sucesso
        } else {
          result(FlutterError(code: "INVALID_ARGUMENTS", message: "Argumentos inválidos para a notificação.", details: nil))
        }
      } else {
        // Metodo não reconhecido
        result(FlutterMethodNotImplemented)
      }
    }

    // Definir o delegate do UNUserNotificationCenter aqui
    UNUserNotificationCenter.current().delegate = self

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Função para exibir a notificação nativa no iOS
  func showNativeIosNotification(title: String, body: String) {
    let center = UNUserNotificationCenter.current()

    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = UNNotificationSound.default

    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false) // Exibe a notificação imediatamente

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    center.add(request) { (error) in
      if let error = error {
        print("Erro ao agendar notificação no iOS: \(error.localizedDescription)")
      }
    }
  }
}

extension AppDelegate { // Removi ": UNUserNotificationCenterDelegate" daqui
  // Este metodo é chamado quando a notificação é apresentada enquanto o app está em foreground
  override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound]) // Mostrar alerta e som mesmo quando o app está em foreground
  }

  // Este metodo é chamado quando o usuário interage com a notificação (clica, abre, etc.)
  override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    let actionIdentifier = response.actionIdentifier
    if actionIdentifier == UNNotificationDefaultActionIdentifier {
      print("Usuário interagiu com a notificação.")
      // Aqui você pode adicionar alguma lógica a ser executada ao interagir com a notificação
    }
    completionHandler()
  }
}