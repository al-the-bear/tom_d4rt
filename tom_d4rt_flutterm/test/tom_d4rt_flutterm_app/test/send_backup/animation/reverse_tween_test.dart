import 'package:flutter/material.dart';

/// Demonstrates ReverseTween - swaps begin and end of another tween.
dynamic build(BuildContext context) {
  final original = Tween<double>(begin: 0.0, end: 100.0);
  final reversed = ReverseTween<double>(original);

  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 2),
    builder: (context, t, _) {
      final origVal = original.transform(t);
      final revVal = reversed.transform(t);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('ReverseTween Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TweenBar('Original', '0→100', origVal, 100, Colors.blue),
              const SizedBox(width: 24),
              _TweenBar('Reversed', '100→0', revVal, 100, Colors.orange),
            ],
          ),
          const SizedBox(height: 12),
          const Text('ReverseTween swaps begin ↔ end', style: TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      );
    },
  );
}

class _TweenBar extends StatelessWidget {
  final String label, range; final double value, max; final Color color;
  const _TweenBar(this.label, this.range, this.value, this.max, this.color);
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
      Text(range, style: const TextStyle(fontSize: 10)),
      const SizedBox(height: 4),
      Container(
        width: 40, height: 100,
        decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(width: 40, height: (value / max) * 100, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
        ),
      ),
      Text('${value.toInt()}', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    ],
  );
}
