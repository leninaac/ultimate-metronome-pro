import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ultimate_metronome_pro/consts/audios/app_audios.dart';
import 'package:ultimate_metronome_pro/core/audio_player_service/audio_player_service.dart';
import 'package:ultimate_metronome_pro/core/scheduler/metronome_scheduler.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/metronome/metronome_controller.dart';
import 'package:ultimate_metronome_pro/features/presenter/modules/timer/timer_controller.dart';

class MockMetronomeScheduler extends Mock implements MetronomeScheduler {}

class MockAudioPlayerService extends Mock implements AudioPlayerService {}
class MockTimerController extends Mock implements TimerController {}

void main() {
  late MetronomeController controller;
  late MockAudioPlayerService audioService;
  late MockTimerController timerController;

  setUp(() {
    audioService = MockAudioPlayerService();
    timerController = MockTimerController();

    when(() => audioService.startPlayer()).thenAnswer((_) async {});
    when(() => audioService.preloadSounds(any(), any())).thenAnswer((_) async {});
    when(() => audioService.playSound(any())).thenAnswer((_) async {});
    when(() => timerController.isCountdownRunning).thenReturn(true);
    when(() => timerController.remainingMilliseconds).thenReturn(1000);
    when(() => timerController.timerType).thenReturn('Countdown');

    controller = MetronomeController(audioService, timerController);
  });

  test('startMetronome sets metronomeIsRunning and starts scheduler', () async {
    controller.scheduler = MetronomeScheduler(
      interval: Duration(milliseconds: 500),
      onTick: () {},
    );

    await controller.startMetronome();

    expect(controller.metronomeIsRunning, isTrue);
  });

  test('startMetronome sets metronomeIsRunning to true', () async {
    await controller.startMetronome();
    expect(controller.metronomeIsRunning, isTrue);
  });

  test('playTick plays tick1 on first beat and updates positions', () async {
    controller.audioTickPosition = 1;
    controller.visualTickPosition = -1;
    controller.numerator = 4;

    await controller.playTick();

    verify(() => audioService.playSound(AppAudios.tick1Audio)).called(1);
    expect(controller.audioTickPosition, 2);
    expect(controller.visualTickPosition, 0);
  });

  test('playTick plays tick2 on non-first beats', () async {
    controller.audioTickPosition = 2;
    controller.visualTickPosition = 0;
    controller.numerator = 4;

    await controller.playTick();

    verify(() => audioService.playSound(AppAudios.tick2Audio)).called(1);
    expect(controller.audioTickPosition, 3);
    expect(controller.visualTickPosition, 1);
  });



  test('stopMetronome resets state', () {
    controller.metronomeIsRunning = true;
    controller.audioTickPosition = 3;
    controller.visualTickPosition = 2;
    controller.currentMeasureCount = 5;

    controller.scheduler = MockMetronomeScheduler();
    when(() => controller.scheduler.stop()).thenReturn(null);
    controller.stopMetronome();

    expect(controller.metronomeIsRunning, isFalse);
    expect(controller.audioTickPosition, 1);
    expect(controller.visualTickPosition, -1);
    expect(controller.currentMeasureCount, 0);
  });

  test('restartMetronome stops and starts scheduler', () {
    controller.scheduler = MetronomeScheduler(
      interval: Duration(milliseconds: 500),
      onTick: () {},
    );

    controller.metronomeIsRunning = true;
    controller.restartMetronome();

    expect(controller.scheduler.isRunning, isTrue);
  });


  test('setBpm updates bpm and sliderValue', () {
    controller.metronomeIsRunning = false;
    controller.setBpm(150);
    expect(controller.bpm, 150);
    expect(controller.sliderValue, 150);
  });

  test('handleMeasureCompletion triggers bpm change when enabled', () {
    controller.enableBpmChange = true;
    controller.measuresToChange = 2;
    controller.bpm = 100;
    controller.bpmChangeValue = 10;
    controller.currentMeasureCount = 2;

    controller.handleMeasureCompletion();

    expect(controller.bpm, 110);
    expect(controller.currentMeasureCount, 0);
  });

  test('handleMeasureCompletion triggers BPM change when enabled and measure count reached', () {
    controller.enableBpmChange = true;
    controller.measuresToChange = 2;
    controller.bpm = 100;
    controller.bpmChangeValue = 10;
    controller.currentMeasureCount = 2;

    controller.handleMeasureCompletion();

    expect(controller.bpm, 110);
    expect(controller.currentMeasureCount, 0);
  });

  test('handleMeasureCompletion does not change BPM when disabled', () {
    controller.enableBpmChange = false;
    controller.bpm = 100;
    controller.bpmChangeValue = 10;
    controller.currentMeasureCount = 1;

    controller.handleMeasureCompletion();

    expect(controller.bpm, 100);
    expect(controller.currentMeasureCount, 2);
  });

  test('setNumerator restarts metronome when running', () async {
    controller.metronomeIsRunning = true;
    controller.scheduler = MetronomeScheduler(
      interval: Duration(milliseconds: 500),
      onTick: () {},
    );

    await controller.startMetronome(); // garante que o estado esteja consistente

    controller.setNumerator(3);

    expect(controller.numerator, 3);
    expect(controller.audioTickPosition, 1);
    expect(controller.visualTickPosition, -1); // ← valor real após reset
    expect(controller.currentMeasureCount, 0);
  });


  test('setBpm clamps BPM to minimum and maximum', () {
    controller.setBpm(10); // abaixo do mínimo
    expect(controller.bpm, 20);

    controller.setBpm(350); // acima do máximo
    expect(controller.bpm, 300);
  });

  test('setSubdivision updates value correctly', () {
    controller.setSubdivision(8);
    expect(controller.subdivision, 8);
  });

  test('timeSignature returns correct string', () {
    controller.numerator = 6;
    controller.denominator = 8;
    expect(controller.timeSignature, '6/8');
  });




  test('playTick stops metronome if countdown finished', () async {
    when(() => timerController.isCountdownRunning).thenReturn(false);
    when(() => timerController.remainingMilliseconds).thenReturn(0);
    when(() => timerController.timerType).thenReturn('Countdown');

    controller.metronomeIsRunning = true;
    controller.scheduler = MetronomeScheduler(
      interval: Duration(milliseconds: 500),
      onTick: () {},
    );

    await controller.playTick();

    expect(controller.metronomeIsRunning, isFalse);
  });

}
