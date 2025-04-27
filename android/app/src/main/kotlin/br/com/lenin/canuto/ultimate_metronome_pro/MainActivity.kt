package br.com.lenin.canuto.ultimate_metronome_pro
import br.com.lenin.canuto.ultimate_metronome_pro.R

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import android.app.NotificationManager
import android.app.NotificationChannel
import android.content.Context
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat

class MainActivity: FlutterActivity() {
    private val CHANNEL = "br.com.lenin.canuto.ultimateMetronomePro"
    private val NOTIFICATION_CHANNEL_ID = "metronome_notification_channel"
    private val NOTIFICATION_CHANNEL_NAME = "Alertas do Metrônomo"
    private val NOTIFICATION_ID = 1 // Você pode usar um ID único para sua notificação

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "showNotification") {
                val title = call.argument<String>("title")
                val body = call.argument<String>("body")
                if (title != null && body != null) {
                    showNotification(title, body)
                    result.success(null) // Indica sucesso de volta para o Flutter
                } else {
                    result.error("INVALID_ARGUMENTS", "Título ou corpo não podem ser nulos", null)
                }
            } else {
                result.notImplemented() // Trata métodos não implementados
            }
        }
    }

    private fun createNotificationChannel() {
        // Cria o NotificationChannel, mas apenas no API 26+ porque
        // a classe NotificationChannel é nova e não está na support library
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel(NOTIFICATION_CHANNEL_ID, NOTIFICATION_CHANNEL_NAME, importance).apply {
                description = "Notificações para alertas do metrônomo"
            }
            // Registra o canal com o sistema
            val notificationManager: NotificationManager =
                getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

    private fun showNotification(title: String, body: String) {
        createNotificationChannel() // Garante que o canal seja criado (seguro chamar múltiplas vezes)

        val builder = NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID)
            .setSmallIcon(R.mipmap.ic_launcher) // Substitua pelo ícone pequeno do seu app
            .setContentTitle(title)
            .setContentText(body)
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
        // Adicione mais opções de notificação aqui se necessário (por exemplo, ação ao tocar)

        with(NotificationManagerCompat.from(this)) {
            // notificationId é um int único para cada notificação que você deve definir
            notify(NOTIFICATION_ID, builder.build())
        }
    }
}
