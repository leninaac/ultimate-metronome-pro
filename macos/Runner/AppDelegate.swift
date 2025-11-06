import FlutterMacOS
import Cocoa
import UserNotifications

@main
class AppDelegate: FlutterAppDelegate {

    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    override func applicationDidFinishLaunching(_ aNotification: Notification) {
        mainFlutterWindow?.title = "Ultimate Metronome Pro"
        
        // Define um estilo de janela fixo, sem a opção de redimensionamento
        mainFlutterWindow?.styleMask = [.titled, .closable, .miniaturizable]

        let flutterViewController = mainFlutterWindow?.contentViewController as! FlutterViewController
        let notificationChannelName = "br.com.lenin.canuto.ultimateMetronomePro"
        let notificationChannel = FlutterMethodChannel(name: notificationChannelName,
                                                       binaryMessenger: flutterViewController.engine.binaryMessenger)

        notificationChannel.setMethodCallHandler {
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in

            guard call.method == "showNotification" else {
                result(FlutterMethodNotImplemented)
                return
            }

            self.handleShowNotification(call: call, result: result)
        }

        // Solicitar permissão para notificações ao iniciar o aplicativo no macOS
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Erro ao solicitar permissão para notificações no macOS: \(error.localizedDescription)")
                return
            }
            if granted {
                print("Permissão para notificações concedida no macOS.")
            } else {
                print("Permissão para notificações negada no macOS.")
            }
        }
    }

    private func handleShowNotification(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let title = args["title"] as? String,
              let body = args["body"] as? String else {
            result(FlutterError(code: "INVALID_ARGS", message: "Argumentos inválidos ou ausentes (title, body)", details: nil))
            return
        }

        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)

        center.add(request) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Erro ao adicionar notificação: \(error.localizedDescription)")
                    result(FlutterError(code: "SCHEDULING_ERROR", message: "Erro ao agendar notificação: \(error.localizedDescription)", details: nil))
                } else {
                    print("Notificação agendada com sucesso.")
                    result(nil)
                }
            }
        }
    }

    override func applicationWillFinishLaunching(_ notification: Notification) {
        UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let actionIdentifier = response.actionIdentifier
        if actionIdentifier == UNNotificationDefaultActionIdentifier {
            print("Usuário clicou na notificação.")
        }
        completionHandler()
    }
}