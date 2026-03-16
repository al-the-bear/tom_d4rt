import 'package:flutter/material.dart';

/// Demonstrates ConstantTween - returns the same value regardless of animation progress.
dynamic build(BuildContext context) {
  final tween = ConstantTween<double>(42.0);

  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 2),
    builder: (context, t, _) {
      final constVal = tween.transform(t);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('ConstantTween Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(16)),
            child: Text('${constVal.toInt()}', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.purple)),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: t),
          const SizedBox(height: 8),
          Text('t = ${t.toStringAsFixed(2)} → always 42', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
          const SizedBox(height: 8),
          const Text('Useful for conditional animations', style: TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      );
    },
  );
}
