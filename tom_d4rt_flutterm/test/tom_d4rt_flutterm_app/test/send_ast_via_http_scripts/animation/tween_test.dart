import 'package:flutter/material.dart';

/// Demonstrates Tween<T> - the fundamental interpolation class.
dynamic build(BuildContext context) {
  final doubleTween = Tween<double>(begin: 0.0, end: 100.0);

  return TweenAnimationBuilder<double>(
    tween: doubleTween,
    duration: const Duration(seconds: 2),
    builder: (context, value, _) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Tween Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              const Text('Tween<double>(begin: 0, end: 100)', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('0', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 150,
                    child: Stack(
                      children: [
                        Container(height: 8, decoration: BoxDecoration(color: Colors.blue.shade200, borderRadius: BorderRadius.circular(4))),
                        FractionallySizedBox(
                          widthFactor: value / 100,
                          child: Container(height: 8, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(4))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('100', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Text('Current: ${value.toStringAsFixed(1)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text('lerp(begin, end, t) = begin + (end-begin)*t', style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Colors.grey)),
      ],
    ),
  );
}
