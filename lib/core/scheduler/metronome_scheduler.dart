import 'dart:async';

class MetronomeScheduler {
  final Duration interval;
  final void Function() onTick;
  Timer? _timer;

  MetronomeScheduler({required this.interval, required this.onTick});

  void start() {
    _timer = Timer(interval, () {
      onTick();
      start();
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void restart() {
    stop();
    start();
  }

  bool get isRunning => _timer?.isActive ?? false;
}
