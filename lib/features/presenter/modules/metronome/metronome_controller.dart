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
    debugPrint('numerador atualizado para: $numerator');
  }

  @action
  setDenominator(int value) {
    denominator = value;
    debugPrint('Denominador atualizado para: $denominator');
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

  @action
  void startMetronome() {
    stopMetronome();

    final interval = Duration(milliseconds: (60000 ~/ bpm).round());
    metronomeTimer = Timer.periodic(interval, (timer) {
      playTick();
      debugPrint('Tick');
    });
    metronomeIsRunning = true;
  }

  @action
  void stopMetronome() {
    metronomeTimer?.cancel();
    audioTickPosition = 1;
    visualTickPosition = 0;
    metronomeIsRunning = false;
  }

  Future<void> preloadAudio() async {
    audioPlayer.setPlayerMode(PlayerMode.lowLatency);
    await audioPlayer.setSource(AssetSource(AppAudios.tick1Audio));
    await audioPlayer.setSource(AssetSource(AppAudios.tick2Audio));

  }

  Future<void> playTick() async {

    audioTickPosition == 1
        ? await audioPlayer.play(AssetSource(AppAudios.tick1Audio))
        : await audioPlayer.play(AssetSource(AppAudios.tick2Audio));

    debugPrint('Tick position: $audioTickPosition');
    visualTickPosition++;
    audioTickPosition++;
    visualTickPosition > numerator ? visualTickPosition = 1 : visualTickPosition;
    audioTickPosition > numerator ? audioTickPosition = 1 : audioTickPosition;
  }
}
