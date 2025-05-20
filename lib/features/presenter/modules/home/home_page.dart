import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:ultimate_metronome_pro/core/utils/input_formatters/bpm_input_formatter.dart';
import '../../../../design_system/painters/animated_arc_painter.dart';


class HomePage extends StatefulWidget {
  final int remainingTimeInSeconds;
  final Color? baseArcColor;
  final Color? animatedArcColor;
  final double? strokeWidth;
  final int initialBpm;

  const HomePage({
    super.key,
    required this.remainingTimeInSeconds,
    this.baseArcColor,
    this.animatedArcColor,
    this.strokeWidth,
    required this.initialBpm,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late TextEditingController _bpmTextController;
  late FocusNode _bpmFocusNode;
  late BpmInputFormatter _bpmInputCorrector;

  late String _initialBpmString;

  @override
  void initState() {
    super.initState();

    _bpmInputCorrector = const BpmInputFormatter(minBpm: 20, maxBpm: 400, defaultBpm: 120);

    _initialBpmString = widget.initialBpm.toString();

    _bpmTextController = TextEditingController(text: _initialBpmString);
    _bpmFocusNode = FocusNode();

    _bpmFocusNode.addListener(_handleFocusChange);

    _controller = AnimationController(vsync: this, duration: Duration(seconds: widget.remainingTimeInSeconds));
    const totalSweepAngle = 4 * math.pi / 3;
    _animation = Tween<double>(begin: 0.0, end: totalSweepAngle).animate(_controller);

    _animation.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        debugPrint("Animação do arco concluída!");
      }
    });

    _controller.forward();
  }

  void _handleFocusChange() {
    if (_bpmFocusNode.hasFocus) {
      _bpmTextController.clear();
    } else {
      String currentValue = _bpmTextController.text;
      int? parsedValue = int.tryParse(currentValue);

      int finalBpm;
      if (parsedValue == null) {
        finalBpm = widget.initialBpm;
      } else {
        finalBpm = math.max(20, math.min(400, parsedValue));
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _bpmTextController.text = finalBpm.toString();
          _bpmTextController.selection = TextSelection.fromPosition(
              TextPosition(offset: _bpmTextController.text.length));
        }
      });
    }
  }

  void _handleOnChanged(String newValue) {}


  @override
  void dispose() {
    _controller.dispose();
    _bpmFocusNode.removeListener(_handleFocusChange);
    _bpmTextController.dispose();
    _bpmFocusNode.dispose();
    super.dispose();
  }

  int get currentBpmValue {
    return int.tryParse(_bpmTextController.text) ?? _bpmInputCorrector.defaultBpm;
  }

  @override
  Widget build(BuildContext context) {
    const double widgetSize = 200;
    const double bpmPositionedBottom = 40;

    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _bpmFocusNode.unfocus(),
          child: Center(
            child: SizedBox(
              width: widgetSize,
              height: widgetSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: AnimatedArcPainter(
                        animatedSweepAngle: _animation.value,
                        baseArcColor: widget.baseArcColor ?? Colors.blue,
                        animatedArcColor: widget.animatedArcColor ?? Colors.white,
                        strokeWidth: widget.strokeWidth ?? 8,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 80,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _bpmTextController,
                        focusNode: _bpmFocusNode,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        decoration: const InputDecoration.collapsed(hintText: ''),
                        onChanged: _handleOnChanged,
                        onSubmitted: (_) => _bpmFocusNode.unfocus(),
                        cursorHeight: 36,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: bpmPositionedBottom,
                    child: Center(
                      child: Text(
                        'BPM',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
