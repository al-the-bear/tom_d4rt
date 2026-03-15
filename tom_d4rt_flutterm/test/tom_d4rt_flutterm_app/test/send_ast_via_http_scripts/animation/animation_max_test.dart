import 'package:flutter/material.dart';

/// Demonstrates AnimationMax - combines two animations, outputting the maximum value.
dynamic build(BuildContext context) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 3),
    builder: (context, t, _) {
      final a = Curves.easeIn.transform(t);
      final b = Curves.easeOut.transform(t);
      final maxVal = a > b ? a : b;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('AnimationMax Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _Bar('A', a, Colors.blue),
              const SizedBox(width: 8),
              _Bar('B', b, Colors.orange),
              const SizedBox(width: 16),
              _Bar('MAX', maxVal, Colors.green),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
            child: Text('AnimationMax(A, B) = ${(maxVal * 100).toInt()}%',
                style: const TextStyle(fontWeight: FontWeight.bold)),
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
  const _Bar(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${(value * 100).toInt()}%', style: TextStyle(fontSize: 10, color: color)),
        Container(width: 40, height: 80 * value, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
