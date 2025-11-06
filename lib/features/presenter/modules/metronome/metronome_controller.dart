import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:ultimate_metronome_pro/consts/audios/app_audios.dart';
import 'package:ultimate_metronome_pro/core/audio_player_service/audio_player_service.dart';
import 'package:ultimate_metronome_pro/core/enums/musical_tempo_enum.dart';
import 'package:ultimate_metronome_pro/core/scheduler/metronome_scheduler.dart';
import '../timer/timer_controller.dart';

part 'metronome_controller.g.dart';

class MetronomeController = MetronomeControllerAbstract with _$MetronomeController;

abstract class MetronomeControllerAbstract with Store {
  final AudioPlayerService audioPlayerService;
  final TimerController timerController;

  MetronomeControllerAbstract(this.audioPlayerService, this.timerController);

  late MetronomeScheduler scheduler;

  @observable
  double bpm = 120;
  @observable
  bool metronomeIsRunning = false;
  @observable
  int audioTickPosition = 1;
  @observable
  int visualTickPosition = -1;
  @observable
  double sliderValue = 60;
  @observable
  int numerator = 4;
  @observable
  int denominator = 4;
  @observable
  int subdivision = 4;
  @observable
  bool enableBpmChange = false;
  @observable
  int measuresToChange = 4;
  @observable
  double bpmChangeValue = 5;
  @observable
  int currentMeasureCount = 0;
  @observable
  String musicalTempo = '';

  @computed
  String get timeSignature => '$numerator/$denominator';

  @computed
  bool get isBpmChangeWarningActive =>
      enableBpmChange &&
          metronomeIsRunning &&
          currentMeasureCount == measuresToChange - 1;

  @action
  void setSubdivision(int value) {
    subdivision = value;
    debugPrint('Subdivisão atualizada para: $subdivision');
  }

  @action
  void setNumerator(int value) {
    numerator = value;
    if (metronomeIsRunning) {
      audioTickPosition = 1;
      visualTickPosition = 0;
      currentMeasureCount = 0;
      restartMetronome();
    }
    debugPrint('Numerador atualizado para: $numerator');
  }

  @action
  void setDenominator(int value) {
    denominator = value;
    debugPrint('Denominador atualizado para: $denominator');
  }

  @action
  String getMusicalTempoFromBpm(double bpm) {
    return MusicalTempo.fromBpm(bpm).label;
  }

  @action
  void setEnableBpmChange(bool value) {
    enableBpmChange = value;
    if (!value) currentMeasureCount = 0;
  }

  @action
  void setMeasuresToChange(int value) {
    measuresToChange = value.clamp(1, 999);
    currentMeasureCount = 0;
    debugPrint('Compassos para mudar BPM atualizado para: $measuresToChange');
  }

  @action
  void setBpmChangeValue(double value) {
    bpmChangeValue = value.clamp(-999, 999);
    debugPrint('Valor para mudar BPM atualizado para: $bpmChangeValue');
  }

  @action
  void setBpm(double newBpm) {
    bpm = newBpm.clamp(20, 300);
    sliderValue = bpm;
  }

  void restartMetronome() {
    scheduler.stop();
    _startScheduler();
  }

  void _startScheduler() {
    final interval = Duration(milliseconds: (60000 / bpm).round());
    scheduler = MetronomeScheduler(interval: interval, onTick: playTick);
    scheduler.start();
  }

  @action
  Future<void> startMetronome() async {
    if (metronomeIsRunning) return;

    if (!audioPlayerService.isInitialized) {
      debugPrint('AudioPlayerService não está pronto. Ignorando startMetronome.');
      return;
    }

    metronomeIsRunning = true;
    await playTick();
    _startScheduler();
  }

  @action
  void stopMetronome() {
    metronomeIsRunning = false;
    scheduler.stop();
    audioTickPosition = 1;
    visualTickPosition = -1;
    currentMeasureCount = 0;
  }

  Future<void> playTick() async {
    if (timerController.timerType == 'Countdown' &&
        !timerController.isCountdownRunning &&
        timerController.remainingMilliseconds <= 0) {
      stopMetronome();
      return;
    }

    final audioPath = audioTickPosition == 1
        ? AppAudios.tick1Audio
        : AppAudios.tick2Audio;

    try {
      await audioPlayerService.playSound(audioPath);
    } catch (e) {
      debugPrint("Erro ao tocar áudio: $e");
    }

    debugPrint('Tick: $audioTickPosition, Visual: $visualTickPosition, Compasso: $currentMeasureCount');

    final measureCompleted = audioTickPosition == numerator;
    visualTickPosition++;
    audioTickPosition++;

    if (audioTickPosition > numerator) audioTickPosition = 1;
    if (visualTickPosition >= numerator) visualTickPosition = 0;

    if (measureCompleted) handleMeasureCompletion();
  }

  @action
  void handleMeasureCompletion() {
    currentMeasureCount++;
    debugPrint('Compasso $currentMeasureCount concluído.');

    if (enableBpmChange && currentMeasureCount >= measuresToChange) {
      final nextBpm = bpm + bpmChangeValue;
      setBpm(nextBpm);
      if (metronomeIsRunning) {
        restartMetronome();
      }

      currentMeasureCount = 0;
      debugPrint('BPM alterado para $bpm. Contagem de compassos resetada.');
    }
  }
}
