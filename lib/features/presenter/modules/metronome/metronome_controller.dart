import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:ultimate_metronome_pro/consts/audios/app_audios.dart';

part 'metronome_controller.g.dart';

class MetronomeController = MetronomeControllerAbstract with _$MetronomeController;

abstract class MetronomeControllerAbstract with Store {
  @observable
  int bpm = 60;
  Timer? metronomeTimer;
  @observable
  bool metronomeIsRunning = false;
  @observable
  int audioTickPosition = 1;
  @observable
  int visualTickPosition = 0;
  @observable
  double sliderValue = 60;
  @observable
  int numerator = 4;
  @observable
  int denominator = 4;
  @observable
  int subdivision = 4;
  final AudioPlayer audioPlayer = AudioPlayer();
  @observable
  bool enableBpmChange = false;
  @observable
  int measuresToChange = 4;
  @observable
  int bpmChangeValue = 5;
  @observable
  int currentMeasureCount = 0;

  @computed
  String get timeSignature => '$numerator/$denominator';

  @action
  setSubdivision(int value){
    subdivision = value;
    debugPrint('subdivisão atualizado para: $subdivision');
  }

  @action
  setNumerator(int value) {
    numerator = value;
    if(metronomeIsRunning) {
      audioTickPosition = 1;
      visualTickPosition = 0;
      currentMeasureCount = 0;
      stopMetronome();
      startMetronome();
    }
    debugPrint('numerador atualizado para: $numerator');
  }

  @action
  setDenominator(int value) {
    denominator = value;
    debugPrint('Denominador atualizado para: $denominator');
}

  @action
  void setEnableBpmChange(bool value) {
    enableBpmChange = value;
    if(!value) currentMeasureCount = 0;
  }

  @action
  void seMeasuresToChange(int value) {
    measuresToChange = value.clamp(1, 999);
    currentMeasureCount = 0;
    debugPrint('Compassos para mudar BPM atualizado para: $measuresToChange');
  }

  @action
  void setBpmChangeValue(int value) {
    bpmChangeValue = value.clamp(1, 999);
    debugPrint('Valor para mudar BPM atualizado para: $bpmChangeValue');
  }

  @action
  void setBpm(int newBpm) {
    bpm = newBpm.clamp(20, 300);
    sliderValue = bpm.toDouble();

    if (metronomeIsRunning) {
      stopMetronome();
      startMetronome();
    }
  }

  void restartMetronome() {
    metronomeTimer?.cancel();
    final interval = Duration(milliseconds: (60000 ~/ bpm).round());
    metronomeTimer = Timer.periodic(interval, (timer) {
      playTick();
    });
  }

  @action
  void startMetronome() {
    if(metronomeIsRunning) return;

    stopMetronome();

    audioTickPosition = 1;
    visualTickPosition = 0;
    currentMeasureCount = 0;

    preloadAudio();
    restartMetronome();

    metronomeIsRunning = true;
  }

  @action
  void stopMetronome() {
    metronomeTimer?.cancel();
    metronomeTimer = null;

    audioTickPosition = 1;
    visualTickPosition = 0;
    currentMeasureCount = 0;
    metronomeIsRunning = false;
  }

  Future<void> preloadAudio() async {
    audioPlayer.setPlayerMode(PlayerMode.lowLatency);
    await audioPlayer.setSource(AssetSource(AppAudios.tick1Audio));
    await audioPlayer.setSource(AssetSource(AppAudios.tick2Audio));
    debugPrint('Pré-carregamento de áudio iniciado (implementação pode variar)');
  }

  Future<void> playTick() async {
    try{
      audioTickPosition == 1
          ? await audioPlayer.play(AssetSource(AppAudios.tick1Audio), mode: PlayerMode.lowLatency)
          : await audioPlayer.play(AssetSource(AppAudios.tick2Audio), mode: PlayerMode.lowLatency);
    } catch (e) {
      debugPrint("Erro ao tocar áudio: $e");
    }

    debugPrint('Tick position: $audioTickPosition, Visual: $visualTickPosition, Measure: $currentMeasureCount');

    bool measureCompleted = audioTickPosition == numerator;
    visualTickPosition++;
    audioTickPosition++;

    if (audioTickPosition > numerator) {
      audioTickPosition = 1;
    }
    if (visualTickPosition >= numerator) {
      visualTickPosition = 0;
    }

    if (measureCompleted) {
      handleMeasureCompletion();
    }
    // visualTickPosition > numerator ? visualTickPosition = 1 : visualTickPosition;
    // audioTickPosition > numerator ? audioTickPosition = 1 : audioTickPosition;
  }

  @action
  void handleMeasureCompletion() {
    currentMeasureCount++;
    debugPrint('Compasso $currentMeasureCount concluído.');

    if (enableBpmChange && currentMeasureCount >= measuresToChange) {
      debugPrint('Atingiu $measuresToChange compassos. Mudando BPM...');
      final int nextBpm = bpm + bpmChangeValue;
      setBpm(nextBpm);

      currentMeasureCount = 0;
      debugPrint('BPM alterado para $bpm. Contagem de compassos resetada.');
    }

    // if (currentMeasureCount >= measuresToChange) {
    //   setBpm(bpm + bpmChangeValue);
    //   currentMeasureCount = 0;
    // }
  }
}
