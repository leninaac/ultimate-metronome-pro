import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mobx/mobx.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/metronome/metronome_controller.dart';

import '../../../../core/alarm_notifier/alarm_notifier.dart';

part 'timer_controller.g.dart';

class TimerController = TimerControllerAbstract with _$TimerController;

abstract class TimerControllerAbstract with Store {
  @observable
  int stopwatchHours = 00;
  @observable
  int stopwatchMinutes = 00;
  @observable
  int stopwatchSeconds = 00;
  @observable
  int countdownHours = 00;
  @observable
  int countdownMinutes = 00;
  @observable
  int countdownSeconds = 00;
  @observable
  int milliseconds = 00;

  @observable
  int remainingMilliseconds = 0;
  @observable
  bool isStopwatchRunning = false;
  @observable
  bool isCountdownRunning = false;
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
  setStopwatchHours(int value) {
    stopwatchHours = value;
    debugPrint('horas atualizadas para: $stopwatchHours');
  }

  @action
  setStopwatchMinutes(int value) {
    stopwatchMinutes = value;
    debugPrint('minutos atualizados para: $stopwatchMinutes');
  }

  @action
  setStopwatchSeconds(int value) {
    stopwatchSeconds = value;
    debugPrint('segundos atualizados para: $stopwatchSeconds');
  }

  @action
  setCountdownHours(int value) {
    countdownHours = value;
    debugPrint('horas atualizadas para: $countdownHours');
  }

  @action
  setCountdownMinutes(int value) {
    countdownMinutes = value;
    debugPrint('minutos atualizados para: $countdownMinutes');
  }

  @action
  setCountdownSeconds(int value) {
    countdownSeconds = value;
    debugPrint('segundos atualizados para: $countdownSeconds');
  }

  @action
  void startStopwatch() {
    isStopwatchRunning = true;

    debugPrint('Cronômetro iniciado');
    if (stopwatchTimer != null) {
      stopwatchTimer!.cancel();
    }
    stopwatchTimer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      milliseconds++;
      if (milliseconds == 1000) {
        stopwatchSeconds++;
        milliseconds = 0;
      }
      if (stopwatchSeconds == 60) {
        stopwatchMinutes++;
        stopwatchSeconds = 0;
      }
    });
  }

  @action
  void pauseStopwatch() {
    debugPrint('Cronômetro pausado');
    stopwatchTimer!.cancel();
    isStopwatchRunning = false;
  }

  @action
  void stopStopwatch() {
    debugPrint('Cronômetro parado');
    stopwatchTimer!.cancel();
    isStopwatchRunning = false;
  }

  @action
  void resetStopwatch() {
    stopStopwatch();
    stopwatchMinutes = 0;
    stopwatchSeconds = 0;
    milliseconds = 0;
  }

  @action
  void setCountdownTimer() {
    remainingMilliseconds = (countdownHours * 3600 + countdownMinutes * 60 + countdownSeconds) * 1000;
    debugPrint('Tempo configurado para countdown: $remainingMilliseconds ms');
  }

  @action
  void startCountdownTimer(MetronomeController metronomeController) {
    if (isCountdownRunning) return;
    isCountdownRunning = true;
    debugPrint('Countdown iniciado');
    setCountdownTimer();

    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingMilliseconds <= 0) {
        pauseCountdownTimer();
        debugPrint('Countdown atingiu zero.');
        if(metronomeController.metronomeIsRunning) {
          metronomeController.stopMetronome();
          debugPrint('Metronomo Parou.');
        }
        AlarmNotifier.forPlatformSpecific('Alarme', 'Tempo finalizado');
      } else {
        remainingMilliseconds -= 1000;

        int totalSeconds = remainingMilliseconds ~/ 1000;
        countdownHours = totalSeconds ~/ 3600;
        countdownMinutes = (totalSeconds % 3600) ~/ 60;
        countdownSeconds = totalSeconds % 60;
      }
    });
  }

  @action
  void pauseCountdownTimer() {
    countdownTimer?.cancel();
    isCountdownRunning = false;
    debugPrint('Countdown pausado');
  }

  @action
  void resetCountdownTimer() {
    pauseCountdownTimer();
    remainingMilliseconds = 0;
    countdownHours = 0;
    countdownMinutes = 0;
    countdownSeconds = 0;
    debugPrint('Countdown resetado');
    isCountdownRunning = false;
  }
}
