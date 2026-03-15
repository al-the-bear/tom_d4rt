import 'package:flutter/material.dart';

/// Demonstrates TweenSequence - chains multiple tweens with weights.
dynamic build(BuildContext context) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 3),
    builder: (context, t, _) {
      // Manual sequence simulation
      double value;
      if (t < 0.33) {
        value = t / 0.33 * 100;
      } else if (t < 0.66) {
        value = 100 - (t - 0.33) / 0.33 * 50;
      } else {
        value = 50 + (t - 0.66) / 0.34 * 30;
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('TweenSequence Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          // Sequence segments
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SeqSegment('0→100', Colors.blue),
              const Icon(Icons.arrow_forward, size: 16),
              _SeqSegment('100→50', Colors.orange),
              const Icon(Icons.arrow_forward, size: 16),
              _SeqSegment('50→80', Colors.green),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: 250, height: value,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.blue, Colors.orange, Colors.green]),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 8),
          Text('Height: ${value.toStringAsFixed(0)}', style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
        ],
      );
    },
  );
}

class _SeqSegment extends StatelessWidget {
  final String range; final Color color;
  const _SeqSegment(this.range, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
    child: Text(range, style: TextStyle(fontSize: 10, color: color)),
  );
}
