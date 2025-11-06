import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:mobx/mobx.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/metronome/metronome_controller.dart';

import '../../../../core/alarm_notifier/alarm_notifier.dart';
import '../../../../core/time_service/countdown_service.dart';
import '../../../../core/time_service/stopwatch_service.dart';

part 'timer_controller.g.dart';

class TimerController = TimerControllerAbstract with _$TimerController;

abstract class TimerControllerAbstract with Store {
  final StopwatchService _stopwatchService = StopwatchService();
  final CountdownService _countdownService = CountdownService();

  @observable
  int stopwatchHours = 0;
  @observable
  int stopwatchMinutes = 0;
  @observable
  int stopwatchSeconds = 0;
  @observable
  int countdownHours = 0;
  @observable
  int countdownMinutes = 0;
  @observable
  int countdownSeconds = 0;
  @observable
  int milliseconds = 0;
  @observable
  int remainingMilliseconds = 0;
  @observable
  bool isStopwatchRunning = false;
  @observable
  bool isCountdownRunning = false;
  @observable
  int countdownSessionId = 0;
  Timer? stopwatchTimer;
  Timer? countdownTimer;
  @observable
  String timerType = 'Indefinido';

  @action
  void setTimerType(String type) {
    timerType = type;
    debugPrint('Tipo de cronômetro atualizado para: $timerType');
  }

  @action
  void setStopwatchHours(int value) {
    stopwatchHours = value;
    debugPrint('horas atualizadas para: $stopwatchHours');
  }

  @action
  void setStopwatchMinutes(int value) {
    stopwatchMinutes = value;
    debugPrint('minutos atualizados para: $stopwatchMinutes');
  }

  @action
  void setStopwatchSeconds(int value) {
    stopwatchSeconds = value;
    debugPrint('segundos atualizados para: $stopwatchSeconds');
  }

  @action
  void setCountdownHours(int value) {
    countdownHours = value;
    debugPrint('horas atualizadas para: $countdownHours');
  }

  @action
  void setCountdownMinutes(int value) {
    countdownMinutes = value;
    debugPrint('minutos atualizados para: $countdownMinutes');
  }

  @action
  void setCountdownSeconds(int value) {
    countdownSeconds = value;
    debugPrint('segundos atualizados para: $countdownSeconds');
  }

  Duration getCountdownDuration() {
    return Duration(
      hours: countdownHours,
      minutes: countdownMinutes,
      seconds: countdownSeconds,
    );
  }

  @action
  void startStopwatch() {
    if (isCountdownRunning) pauseCountdownTimer();
    if (isStopwatchRunning) return;
    isStopwatchRunning = true;
    timerType = 'Stopwatch';

    _stopwatchService.start((h, m, s) {
      stopwatchHours = h;
      stopwatchMinutes = m;
      stopwatchSeconds = s;
    });

    final metronomeController = Modular.get<MetronomeController>();
    if (!metronomeController.metronomeIsRunning) {
      metronomeController.startMetronome();
    }
  }

  @action
  void pauseStopwatch() {
    _stopwatchService.stop();
    isStopwatchRunning = false;
  }

  @action
  void stopStopwatch() {
    debugPrint('Cronômetro parado');
    stopwatchTimer?.cancel();
    isStopwatchRunning = false;
  }

  @action
  void resetStopwatch() {
    _stopwatchService.reset();
    stopwatchHours = 0;
    stopwatchMinutes = 0;
    stopwatchSeconds = 0;
    milliseconds = 0;
    isStopwatchRunning = false;
  }

  @action
  void setCountdownTimer() {
    remainingMilliseconds = (countdownHours * 3600 + countdownMinutes * 60 + countdownSeconds) * 1000;
    debugPrint('Tempo configurado para countdown: $remainingMilliseconds ms');
  }

  @action
  void startCountdownTimer(MetronomeController metronomeController) {
    if (isStopwatchRunning) pauseStopwatch();
    if (isCountdownRunning) return;
    isCountdownRunning = true;
    timerType = 'Countdown';

    final totalMs = (countdownHours * 3600 + countdownMinutes * 60 + countdownSeconds) * 1000;

    _countdownService.start(
      totalMs: totalMs,
      onUpdate: (h, m, s) {
        countdownHours = h;
        countdownMinutes = m;
        countdownSeconds = s;
        remainingMilliseconds = (h * 3600 + m * 60 + s) * 1000;
      },
      onFinish: () {
        pauseCountdownTimer();

        if (metronomeController.metronomeIsRunning) {
          metronomeController.stopMetronome();
        }

        timerType = 'Indefinido';

        AlarmNotifier.forPlatformSpecific('Alarme', 'Tempo finalizado');
      },
    );

    if (!metronomeController.metronomeIsRunning) {
      metronomeController.startMetronome();
    }

    countdownSessionId++;
  }

  @action
  void pauseCountdownTimer() {
    _countdownService.stop();
    isCountdownRunning = false;
  }

  @action
  void resetCountdownTimer() {
    _countdownService.reset();
    countdownHours = 0;
    countdownMinutes = 0;
    countdownSeconds = 0;
    remainingMilliseconds = 0;
    isCountdownRunning = false;
  }
}
