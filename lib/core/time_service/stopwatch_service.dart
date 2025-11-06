

import 'dart:async';

class StopwatchService {
  Timer? _timer;
  int milliseconds = 0;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;

  void start(Function updateCallback) {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 1), (_) {
      milliseconds++;
      if (milliseconds == 1000) {
        seconds++;
        milliseconds = 0;
      }
      if (seconds == 60) {
        minutes++;
        seconds = 0;
      }
      if (minutes == 60) {
        hours++;
        minutes = 0;
      }
      updateCallback(hours, minutes, seconds);
    });
  }

  void stop() => _timer?.cancel();

  void reset() {
    stop();
    milliseconds = 0;
    seconds = 0;
    minutes = 0;
    hours = 0;
  }
}
