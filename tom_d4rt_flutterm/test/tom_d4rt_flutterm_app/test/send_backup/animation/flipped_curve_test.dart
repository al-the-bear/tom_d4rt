import 'package:flutter/material.dart';

/// Demonstrates FlippedCurve - reverses another curve's direction.
dynamic build(BuildContext context) {
  final original = Curves.easeIn;
  final flipped = FlippedCurve(original);

  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 2),
    builder: (context, t, _) {
      final origVal = original.transform(t);
      final flipVal = flipped.transform(t);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('FlippedCurve Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _FlipCol('Original\n(easeIn)', origVal, Colors.blue),
              const SizedBox(width: 24),
              const Icon(Icons.swap_horiz, size: 32),
              const SizedBox(width: 24),
              _FlipCol('Flipped\n(easeOut)', flipVal, Colors.orange),
            ],
          ),
          const SizedBox(height: 12),
          const Text('FlippedCurve(curve) = 1 - curve(1 - t)', style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Colors.grey)),
        ],
      );
    },
  );
}

class _FlipCol extends StatelessWidget {
  final String label; final double value; final Color color;
  const _FlipCol(this.label, this.value, this.color);
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        width: 60, height: 100,
        decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
        child: Align(
          alignment: Alignment(0, 1 - 2 * value),
          child: Container(width: 20, height: 20, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        ),
      ),
      const SizedBox(height: 4),
      Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 9, color: color)),
    ],
  );
}
