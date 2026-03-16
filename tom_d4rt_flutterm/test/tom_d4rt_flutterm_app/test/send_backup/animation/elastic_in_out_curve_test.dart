import 'package:flutter/material.dart';

/// Demonstrates ElasticInOutCurve - elastic at both start and end.
dynamic build(BuildContext context) {
  const curve = ElasticInOutCurve();

  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 2),
    curve: curve,
    builder: (context, value, _) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('ElasticInOutCurve Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        Transform.scale(
          scale: 0.5 + value,
          child: Container(
            width: 80, height: 80,
            decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.star, color: Colors.white, size: 40),
          ),
        ),
        const SizedBox(height: 16),
        Text('Scale: ${(0.5 + value).toStringAsFixed(2)}x', style: const TextStyle(fontFamily: 'monospace')),
        const SizedBox(height: 8),
        const Text('Bouncy at BOTH start and end', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    ),
  );
}
