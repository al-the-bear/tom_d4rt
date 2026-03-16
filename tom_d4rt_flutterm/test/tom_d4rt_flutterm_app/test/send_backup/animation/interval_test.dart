import 'package:flutter/material.dart';

/// Demonstrates Interval - applies a curve to only part of the animation timeline.
dynamic build(BuildContext context) {
  const early = Interval(0.0, 0.5, curve: Curves.easeOut);
  const late = Interval(0.5, 1.0, curve: Curves.easeIn);

  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 3),
    builder: (context, t, _) {
      final earlyVal = early.transform(t);
      final lateVal = late.transform(t);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Interval Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          // Timeline visualization
          Container(
            height: 40, width: 250,
            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Expanded(child: Container(
                  decoration: BoxDecoration(color: Colors.blue.withOpacity(earlyVal), borderRadius: const BorderRadius.horizontal(left: Radius.circular(8))),
                  alignment: Alignment.center,
                  child: const Text('0.0-0.5', style: TextStyle(color: Colors.white, fontSize: 11)),
                )),
                Expanded(child: Container(
                  decoration: BoxDecoration(color: Colors.orange.withOpacity(lateVal), borderRadius: const BorderRadius.horizontal(right: Radius.circular(8))),
                  alignment: Alignment.center,
                  child: const Text('0.5-1.0', style: TextStyle(color: Colors.white, fontSize: 11)),
                )),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text('t=${t.toStringAsFixed(2)}', style: const TextStyle(fontFamily: 'monospace')),
          const SizedBox(height: 12),
          const Text('Sequence animations within timeline segments', style: TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      );
    },
  );
}
