// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metronome_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MetronomeController on MetronomeControllerAbstract, Store {
  Computed<String>? _$timeSignatureComputed;

  @override
  String get timeSignature =>
      (_$timeSignatureComputed ??= Computed<String>(() => super.timeSignature,
              name: 'MetronomeControllerAbstract.timeSignature'))
          .value;

  late final _$bpmAtom =
      Atom(name: 'MetronomeControllerAbstract.bpm', context: context);

  @override
  int get bpm {
    _$bpmAtom.reportRead();
    return super.bpm;
  }

  @override
  set bpm(int value) {
    _$bpmAtom.reportWrite(value, super.bpm, () {
      super.bpm = value;
    });
  }

  late final _$metronomeIsRunningAtom = Atom(
      name: 'MetronomeControllerAbstract.metronomeIsRunning', context: context);

  @override
  bool get metronomeIsRunning {
    _$metronomeIsRunningAtom.reportRead();
    return super.metronomeIsRunning;
  }

  @override
  set metronomeIsRunning(bool value) {
    _$metronomeIsRunningAtom.reportWrite(value, super.metronomeIsRunning, () {
      super.metronomeIsRunning = value;
    });
  }

  late final _$audioTickPositionAtom = Atom(
      name: 'MetronomeControllerAbstract.audioTickPosition', context: context);

  @override
  int get audioTickPosition {
    _$audioTickPositionAtom.reportRead();
    return super.audioTickPosition;
  }

  @override
  set audioTickPosition(int value) {
    _$audioTickPositionAtom.reportWrite(value, super.audioTickPosition, () {
      super.audioTickPosition = value;
    });
  }

  late final _$visualTickPositionAtom = Atom(
      name: 'MetronomeControllerAbstract.visualTickPosition', context: context);

  @override
  int get visualTickPosition {
    _$visualTickPositionAtom.reportRead();
    return super.visualTickPosition;
  }

  @override
  set visualTickPosition(int value) {
    _$visualTickPositionAtom.reportWrite(value, super.visualTickPosition, () {
      super.visualTickPosition = value;
    });
  }

  late final _$sliderValueAtom =
      Atom(name: 'MetronomeControllerAbstract.sliderValue', context: context);

  @override
  double get sliderValue {
    _$sliderValueAtom.reportRead();
    return super.sliderValue;
  }

  @override
  set sliderValue(double value) {
    _$sliderValueAtom.reportWrite(value, super.sliderValue, () {
      super.sliderValue = value;
    });
  }

  late final _$numeratorAtom =
      Atom(name: 'MetronomeControllerAbstract.numerator', context: context);

  @override
  int get numerator {
    _$numeratorAtom.reportRead();
    return super.numerator;
  }

  @override
  set numerator(int value) {
    _$numeratorAtom.reportWrite(value, super.numerator, () {
      super.numerator = value;
    });
  }

  late final _$denominatorAtom =
      Atom(name: 'MetronomeControllerAbstract.denominator', context: context);

  @override
  int get denominator {
    _$denominatorAtom.reportRead();
    return super.denominator;
  }

  @override
  set denominator(int value) {
    _$denominatorAtom.reportWrite(value, super.denominator, () {
      super.denominator = value;
    });
  }

  late final _$subdivisionAtom =
      Atom(name: 'MetronomeControllerAbstract.subdivision', context: context);

  @override
  int get subdivision {
    _$subdivisionAtom.reportRead();
    return super.subdivision;
  }

  @override
  set subdivision(int value) {
    _$subdivisionAtom.reportWrite(value, super.subdivision, () {
      super.subdivision = value;
    });
  }

  late final _$MetronomeControllerAbstractActionController =
      ActionController(name: 'MetronomeControllerAbstract', context: context);

  @override
  dynamic setSubdivision(int value) {
    final _$actionInfo = _$MetronomeControllerAbstractActionController
        .startAction(name: 'MetronomeControllerAbstract.setSubdivision');
    try {
      return super.setSubdivision(value);
    } finally {
      _$MetronomeControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNumerator(int value) {
    final _$actionInfo = _$MetronomeControllerAbstractActionController
        .startAction(name: 'MetronomeControllerAbstract.setNumerator');
    try {
      return super.setNumerator(value);
    } finally {
      _$MetronomeControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDenominator(int value) {
    final _$actionInfo = _$MetronomeControllerAbstractActionController
        .startAction(name: 'MetronomeControllerAbstract.setDenominator');
    try {
      return super.setDenominator(value);
    } finally {
      _$MetronomeControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBpm(int newBpm) {
    final _$actionInfo = _$MetronomeControllerAbstractActionController
        .startAction(name: 'MetronomeControllerAbstract.setBpm');
    try {
      return super.setBpm(newBpm);
    } finally {
      _$MetronomeControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startMetronome() {
    final _$actionInfo = _$MetronomeControllerAbstractActionController
        .startAction(name: 'MetronomeControllerAbstract.startMetronome');
    try {
      return super.startMetronome();
    } finally {
      _$MetronomeControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopMetronome() {
    final _$actionInfo = _$MetronomeControllerAbstractActionController
        .startAction(name: 'MetronomeControllerAbstract.stopMetronome');
    try {
      return super.stopMetronome();
    } finally {
      _$MetronomeControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
bpm: ${bpm},
metronomeIsRunning: ${metronomeIsRunning},
audioTickPosition: ${audioTickPosition},
visualTickPosition: ${visualTickPosition},
sliderValue: ${sliderValue},
numerator: ${numerator},
denominator: ${denominator},
subdivision: ${subdivision},
timeSignature: ${timeSignature}
    ''';
  }
}
