import 'package:flutter/material.dart';

class CustomAnimationProgressWidget extends StatefulWidget {
  final Duration duration;
  final Curve curve;
  final bool autoStart;
  final bool repeat;
  final Widget Function(BuildContext context, double progress, AnimationController controller) builder;

  const CustomAnimationProgressWidget({
    super.key,
    required this.duration,
    required this.builder,
    this.curve = Curves.linear,
    this.autoStart = true,
    this.repeat = true,
  });

  @override
  State<CustomAnimationProgressWidget> createState() => _CustomAnimationProgressWidgetState();
}

class _CustomAnimationProgressWidgetState extends State<CustomAnimationProgressWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);

    if (widget.autoStart) {
      if (widget.repeat) {
        _controller.repeat();
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void didUpdateWidget(covariant CustomAnimationProgressWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    if(widget.autoStart != oldWidget.autoStart) {
      if(widget.autoStart) {
        _controller.forward(from: 0.0);
      } else {
        _controller.stop();
      }
    }

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (ctx, _) => widget.builder(ctx, _animation.value, _controller),
    );
  }
}
