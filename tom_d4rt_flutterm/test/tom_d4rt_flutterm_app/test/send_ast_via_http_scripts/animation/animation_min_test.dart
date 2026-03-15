import 'package:flutter/material.dart';

/// Demonstrates AnimationMin - combines two animations, outputting the minimum value.
dynamic build(BuildContext context) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 3),
    builder: (context, t, _) {
      final a = Curves.easeIn.transform(t);
      final b = Curves.easeOut.transform(t);
      final minVal = a < b ? a : b;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('AnimationMin Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _Bar('A', a, Colors.blue, isMin: a <= b),
              const SizedBox(width: 8),
              _Bar('B', b, Colors.orange, isMin: b <= a),
              const SizedBox(width: 16),
              _Bar('MIN', minVal, Colors.teal, isMin: true),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_downward, color: Colors.teal, size: 18),
                Text(' AnimationMin = ${(minVal * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      );
    },
  );
}

class _Bar extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final bool isMin;
  const _Bar(this.label, this.value, this.color, {this.isMin = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isMin) const Icon(Icons.check, size: 14, color: Colors.teal),
        Container(width: 40, height: 80 * value,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4),
            border: isMin ? Border.all(color: Colors.teal, width: 2) : null)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 11, color: color)),
      ],
    );
  }
}
