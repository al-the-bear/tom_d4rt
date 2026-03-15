import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Demonstrates Animatable<T> - base class for objects that transform Animation values.
dynamic build(BuildContext context) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 2),
    builder: (context, t, _) {
      // Custom animatable: sine wave
      final sineVal = math.sin(t * 2 * math.pi);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Animatable Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Container(
            width: 200, height: 100,
            child: CustomPaint(painter: _SineWavePainter(progress: t, value: sineVal)),
          ),
          const SizedBox(height: 8),
          Text('Custom: sin(t * 2π) = ${sineVal.toStringAsFixed(2)}', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
          const SizedBox(height: 12),
          const Text('Chain: tween.chain(CurveTween(...))', style: TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      );
    },
  );
}

class _SineWavePainter extends CustomPainter {
  final double progress, value;
  _SineWavePainter({required this.progress, required this.value});
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    for (int i = 0; i <= 100; i++) {
      final x = i / 100;
      final y = math.sin(x * 2 * math.pi);
      final px = x * size.width;
      final py = size.height / 2 - y * size.height / 3;
      if (i == 0) path.moveTo(px, py);
      else path.lineTo(px, py);
    }
    canvas.drawPath(path, Paint()..color = Colors.blue..style = PaintingStyle.stroke..strokeWidth = 2);
    final px = progress * size.width;
    final py = size.height / 2 - value * size.height / 3;
    canvas.drawCircle(Offset(px, py), 6, Paint()..color = Colors.red);
  }
  @override
  bool shouldRepaint(covariant _SineWavePainter old) => progress != old.progress;
}
