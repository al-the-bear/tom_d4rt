import 'package:flutter/material.dart';

/// Demonstrates SawTooth - repeating linear curve (resets to 0 multiple times).
dynamic build(BuildContext context) {
  const sawTooth = SawTooth(3); // 3 repetitions

  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 3),
    builder: (context, t, _) {
      final sawVal = sawTooth.transform(t);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('SawTooth Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          SizedBox(
            height: 100, width: 250,
            child: CustomPaint(painter: _SawToothPainter(count: 3, progress: t, sawVal: sawVal)),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('t=${t.toStringAsFixed(2)}', style: const TextStyle(fontFamily: 'monospace')),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(4)),
                child: Text('saw=${sawVal.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontFamily: 'monospace')),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('SawTooth(3) = 3 cycles in one animation', style: TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      );
    },
  );
}

class _SawToothPainter extends CustomPainter {
  final int count; final double progress, sawVal;
  _SawToothPainter({required this.count, required this.progress, required this.sawVal});
  @override
  void paint(Canvas canvas, Size size) {
    // Draw sawtooth pattern
    final path = Path();
    for (int i = 0; i <= 50; i++) {
      final t = i / 50;
      final y = (t * count) % 1.0;
      if (i == 0) path.moveTo(0, size.height - y * size.height);
      else path.lineTo(t * size.width, size.height - y * size.height);
    }
    canvas.drawPath(path, Paint()..color = Colors.green..style = PaintingStyle.stroke..strokeWidth = 2);
    // Current point
    canvas.drawCircle(Offset(progress * size.width, size.height - sawVal * size.height), 6, Paint()..color = Colors.red);
  }
  @override
  bool shouldRepaint(covariant _SawToothPainter old) => progress != old.progress;
}
