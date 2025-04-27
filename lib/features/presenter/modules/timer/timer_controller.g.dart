// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TimerController on TimerControllerAbstract, Store {
  late final _$stopwatchHoursAtom =
      Atom(name: 'TimerControllerAbstract.stopwatchHours', context: context);

  @override
  int get stopwatchHours {
    _$stopwatchHoursAtom.reportRead();
    return super.stopwatchHours;
  }

  @override
  set stopwatchHours(int value) {
    _$stopwatchHoursAtom.reportWrite(value, super.stopwatchHours, () {
      super.stopwatchHours = value;
    });
  }

  late final _$stopwatchMinutesAtom =
      Atom(name: 'TimerControllerAbstract.stopwatchMinutes', context: context);

  @override
  int get stopwatchMinutes {
    _$stopwatchMinutesAtom.reportRead();
    return super.stopwatchMinutes;
  }

  @override
  set stopwatchMinutes(int value) {
    _$stopwatchMinutesAtom.reportWrite(value, super.stopwatchMinutes, () {
      super.stopwatchMinutes = value;
    });
  }

  late final _$stopwatchSecondsAtom =
      Atom(name: 'TimerControllerAbstract.stopwatchSeconds', context: context);

  @override
  int get stopwatchSeconds {
    _$stopwatchSecondsAtom.reportRead();
    return super.stopwatchSeconds;
  }

  @override
  set stopwatchSeconds(int value) {
    _$stopwatchSecondsAtom.reportWrite(value, super.stopwatchSeconds, () {
      super.stopwatchSeconds = value;
    });
  }

  late final _$countdownHoursAtom =
      Atom(name: 'TimerControllerAbstract.countdownHours', context: context);

  @override
  int get countdownHours {
    _$countdownHoursAtom.reportRead();
    return super.countdownHours;
  }

  @override
  set countdownHours(int value) {
    _$countdownHoursAtom.reportWrite(value, super.countdownHours, () {
      super.countdownHours = value;
    });
  }

  late final _$countdownMinutesAtom =
      Atom(name: 'TimerControllerAbstract.countdownMinutes', context: context);

  @override
  int get countdownMinutes {
    _$countdownMinutesAtom.reportRead();
    return super.countdownMinutes;
  }

  @override
  set countdownMinutes(int value) {
    _$countdownMinutesAtom.reportWrite(value, super.countdownMinutes, () {
      super.countdownMinutes = value;
    });
  }

  late final _$countdownSecondsAtom =
      Atom(name: 'TimerControllerAbstract.countdownSeconds', context: context);

  @override
  int get countdownSeconds {
    _$countdownSecondsAtom.reportRead();
    return super.countdownSeconds;
  }

  @override
  set countdownSeconds(int value) {
    _$countdownSecondsAtom.reportWrite(value, super.countdownSeconds, () {
      super.countdownSeconds = value;
    });
  }

  late final _$millisecondsAtom =
      Atom(name: 'TimerControllerAbstract.milliseconds', context: context);

  @override
  int get milliseconds {
    _$millisecondsAtom.reportRead();
    return super.milliseconds;
  }

  @override
  set milliseconds(int value) {
    _$millisecondsAtom.reportWrite(value, super.milliseconds, () {
      super.milliseconds = value;
    });
  }

  late final _$remainingMillisecondsAtom = Atom(
      name: 'TimerControllerAbstract.remainingMilliseconds', context: context);

  @override
  int get remainingMilliseconds {
    _$remainingMillisecondsAtom.reportRead();
    return super.remainingMilliseconds;
  }

  @override
  set remainingMilliseconds(int value) {
    _$remainingMillisecondsAtom.reportWrite(value, super.remainingMilliseconds,
        () {
      super.remainingMilliseconds = value;
    });
  }

  late final _$isStopwatchRunningAtom = Atom(
      name: 'TimerControllerAbstract.isStopwatchRunning', context: context);

  @override
  bool get isStopwatchRunning {
    _$isStopwatchRunningAtom.reportRead();
    return super.isStopwatchRunning;
  }

  @override
  set isStopwatchRunning(bool value) {
    _$isStopwatchRunningAtom.reportWrite(value, super.isStopwatchRunning, () {
      super.isStopwatchRunning = value;
    });
  }

  late final _$isCountdownRunningAtom = Atom(
      name: 'TimerControllerAbstract.isCountdownRunning', context: context);

  @override
  bool get isCountdownRunning {
    _$isCountdownRunningAtom.reportRead();
    return super.isCountdownRunning;
  }

  @override
  set isCountdownRunning(bool value) {
    _$isCountdownRunningAtom.reportWrite(value, super.isCountdownRunning, () {
      super.isCountdownRunning = value;
    });
  }

  late final _$timerTypeAtom =
      Atom(name: 'TimerControllerAbstract.timerType', context: context);

  @override
  String get timerType {
    _$timerTypeAtom.reportRead();
    return super.timerType;
  }

  @override
  set timerType(String value) {
    _$timerTypeAtom.reportWrite(value, super.timerType, () {
      super.timerType = value;
    });
  }

  late final _$TimerControllerAbstractActionController =
      ActionController(name: 'TimerControllerAbstract', context: context);

  @override
  void setTimerType(String type) {
    final _$actionInfo = _$TimerControllerAbstractActionController.startAction(
        name: 'TimerControllerAbstract.setTimerType');
    try {
      return super.setTimerType(type);
    } finally {
      _$TimerControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStopwatchHours(int value) {
    final _$actionInfo = _$TimerControllerAbstractActionController.startAction(
        name: 'TimerControllerAbstract.setStopwatchHours');
    try {
      return super.setStopwatchHours(value);
    } finally {
      _$TimerControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStopwatchMinutes(int value) {
    final _$actionInfo = _$TimerControllerAbstractActionController.startAction(
        name: 'TimerControllerAbstract.setStopwatchMinutes');
    try {
      return super.setStopwatchMinutes(value);
    } finally {
      _$TimerControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStopwatchSeconds(int value) {
    final _$actionInfo = _$TimerControllerAbstractActionController.startAction(
        name: 'TimerControllerAbstract.setStopwatchSeconds');
    try {
      return super.setStopwatchSeconds(value);
    } finally {
      _$TimerControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCountdownHours(int value) {
    final _$actionInfo = _$TimerControllerAbstractActionController.startAction(
        name: 'TimerControllerAbstract.setCountdownHours');
    try {
      return super.setCountdownHours(value);
    } finally {
      _$TimerControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCountdownMinutes(int value) {
    final _$actionInfo = _$TimerControllerAbstractActionController.startAction(
        name: 'TimerControllerAbstract.setCountdownMinutes');
    try {
      return super.setCountdownMinutes(value);
    } finally {
      _$TimerControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCountdownSeconds(int value) {
    final _$actionInfo = _$TimerControllerAbstractActionController.startAction(
        name: 'TimerControllerAbstract.setCountdownSeconds');
    try {
      return super.setCountdownSeconds(value);
    } finally {
      _$TimerControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startStopwatch() {
    final _$actionInfo = _$TimerControllerAbstractActionController.startAction(
        name: 'TimerControllerAbstract.startStopwatch');
    try {
      return super.startStopwatch();
    } finally {
      _$TimerControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pauseStopwatch() {
    final _$actionInfo = _$TimerControllerAbstractActionController.startAction(
        name: 'TimerControllerAbstract.pauseStopwatch');
    try {
      return super.pauseStopwatch();
    } finally {
      _$TimerControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopStopwatch() {
    final _$actionInfo = _$TimerControllerAbstractActionController.startAction(
        name: 'TimerControllerAbstract.stopStopwatch');
    try {
      return super.stopStopwatch();
    } finally {
      _$TimerControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetStopwatch() {
    final _$actionInfo = _$TimerControllerAbstractActionController.startAction(
        name: 'TimerControllerAbstract.resetStopwatch');
    try {
      return super.resetStopwatch();
    } finally {
      _$TimerControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCountdownTimer() {
    final _$actionInfo = _$TimerControllerAbstractActionController.startAction(
        name: 'TimerControllerAbstract.setCountdownTimer');
    try {
      return super.setCountdownTimer();
    } finally {
      _$TimerControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startCountdownTimer(MetronomeController metronomeController) {
    final _$actionInfo = _$TimerControllerAbstractActionController.startAction(
        name: 'TimerControllerAbstract.startCountdownTimer');
    try {
      return super.startCountdownTimer(metronomeController);
    } finally {
      _$TimerControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pauseCountdownTimer() {
    final _$actionInfo = _$TimerControllerAbstractActionController.startAction(
        name: 'TimerControllerAbstract.pauseCountdownTimer');
    try {
      return super.pauseCountdownTimer();
    } finally {
      _$TimerControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetCountdownTimer() {
    final _$actionInfo = _$TimerControllerAbstractActionController.startAction(
        name: 'TimerControllerAbstract.resetCountdownTimer');
    try {
      return super.resetCountdownTimer();
    } finally {
      _$TimerControllerAbstractActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
stopwatchHours: ${stopwatchHours},
stopwatchMinutes: ${stopwatchMinutes},
stopwatchSeconds: ${stopwatchSeconds},
countdownHours: ${countdownHours},
countdownMinutes: ${countdownMinutes},
countdownSeconds: ${countdownSeconds},
milliseconds: ${milliseconds},
remainingMilliseconds: ${remainingMilliseconds},
isStopwatchRunning: ${isStopwatchRunning},
isCountdownRunning: ${isCountdownRunning},
timerType: ${timerType}
    ''';
  }
}
