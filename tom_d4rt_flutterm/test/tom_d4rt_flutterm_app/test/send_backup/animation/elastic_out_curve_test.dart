import 'package:flutter/material.dart';

/// Demonstrates ElasticOutCurve - overshoots target then settles back.
dynamic build(BuildContext context) {
  const curve = ElasticOutCurve();

  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 2),
    curve: curve,
    builder: (context, value, _) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('ElasticOutCurve Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        Container(
          height: 150, width: 50,
          decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
          child: Align(
            alignment: Alignment(0, 1 - 2 * value),
            child: Container(width: 40, height: 40, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              child: const Icon(Icons.arrow_upward, color: Colors.white)),
          ),
        ),
        const SizedBox(height: 12),
        const Text('Elastic bounce at the END', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    ),
  );
}
