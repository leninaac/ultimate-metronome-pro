import 'package:flutter/material.dart';

class CustomAnimationGlowWidget extends StatefulWidget {
  final Duration duration;
  final Curve curve;
  final bool isWarningActive; // Flag para iniciar/parar
  final Widget Function(BuildContext context, double pulseProgress, AnimationController controller) builder;

  const CustomAnimationGlowWidget({
    super.key,
    this.duration = const Duration(milliseconds: 600), // Duração padrão do pulso
    this.curve = Curves.easeInOut, // Curva suave
    required this.isWarningActive,
    required this.builder,
  });

  @override
  State<CustomAnimationGlowWidget> createState() => _CustomAnimationGlowWidgetState();
}

class _CustomAnimationGlowWidgetState extends State<CustomAnimationGlowWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);

    if (widget.isWarningActive) {
      _controller.repeat(reverse: true); // Repetição reversa para pulso 0 -> 1 -> 0 -> 1...
    }
  }

  @override
  void didUpdateWidget(covariant CustomAnimationGlowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Se a duração mudar (caso raro para o glow, mas bom ter)
    if(widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    // LÓGICA PRINCIPAL: Iniciar/Parar a pulsação
    if(widget.isWarningActive != oldWidget.isWarningActive) {
      if(widget.isWarningActive) {
        // Inicia a pulsação
        _controller.value = 0.0;
        // AJUSTE AQUI: Só inicia o repeat se ainda não estiver rodando
        if (!_controller.isAnimating) {
          _controller.repeat(reverse: true);
        }
      } else {
        // Para a pulsação e reseta para 0 (sem glow)
        _controller.stop();
        _controller.value = 0.0;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (ctx, _) => widget.builder(ctx, _animation.value, _controller),
    );
  }
}