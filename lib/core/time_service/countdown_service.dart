import 'dart:async';
import 'dart:ui';

class CountdownService {
  Timer? _timer;
  int remainingMilliseconds = 0;

  void start({
    required int totalMs,
    required Function(int h, int m, int s) onUpdate,
    required VoidCallback onFinish,
  }) {
    remainingMilliseconds = totalMs;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (remainingMilliseconds <= 0) {
        stop();
        onFinish();
      } else {
        remainingMilliseconds -= 1000;
        final totalSeconds = remainingMilliseconds ~/ 1000;
        final h = totalSeconds ~/ 3600;
        final m = (totalSeconds % 3600) ~/ 60;
        final s = totalSeconds % 60;
        onUpdate(h, m, s);
      }
    });
  }

  void stop() => _timer?.cancel();

  void reset() {
    stop();
    remainingMilliseconds = 0;
  }
}
