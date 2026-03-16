import 'package:flutter/material.dart';

/// Deep visual demo for ShapeBorderTween.
/// Animates between ShapeBorder values.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ShapeBorderTween', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ShapeBox(0),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward, size: 12, color: Colors.grey),
          const SizedBox(width: 8),
          _ShapeBox(50),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward, size: 12, color: Colors.grey),
          const SizedBox(width: 8),
          _ShapeBox(100),
        ],
      ),
      const SizedBox(height: 12),
      Container(
        height: 8,
        width: 150,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), gradient: const LinearGradient(colors: [Colors.blue, Colors.purple])),
      ),
      const SizedBox(height: 8),
      const Text('RoundedRectangle → Circle', style: TextStyle(fontSize: 10)),
      const SizedBox(height: 12),
      const Text('lerp(begin, end, t)', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ShapeBox extends StatelessWidget {
  final double percent;
  const _ShapeBox(this.percent);
  @override
  Widget build(BuildContext context) {
    final t = percent / 100;
    final radius = 8 + (22 * t);
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Color.lerp(Colors.blue, Colors.purple, t),
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: Text('\${percent.toInt()}%', style: const TextStyle(color: Colors.white, fontSize: 10)),
    );
  }
}
