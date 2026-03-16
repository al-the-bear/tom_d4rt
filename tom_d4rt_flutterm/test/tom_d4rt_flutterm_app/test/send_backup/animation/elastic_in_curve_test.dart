import 'package:flutter/material.dart';

/// Demonstrates ElasticInCurve - overshoots then settles (elastic at start).
dynamic build(BuildContext context) {
  const curve = ElasticInCurve();

  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 2),
    curve: curve,
    builder: (context, value, _) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('ElasticInCurve Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        Container(
          height: 100, width: 200,
          decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
          child: Align(
            alignment: Alignment(value * 2 - 1, 0),
            child: Container(width: 30, height: 30, decoration: const BoxDecoration(color: Colors.purple, shape: BoxShape.circle)),
          ),
        ),
        const SizedBox(height: 16),
        Text('Progress: ${(value * 100).toInt()}%', style: const TextStyle(fontFamily: 'monospace')),
        const SizedBox(height: 8),
        const Text('Elastic effect at the START of animation', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    ),
  );
}
