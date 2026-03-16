import 'package:flutter/material.dart';

/// Deep visual demo for InkSparkle effect.
/// Shows the Material 3 sparkle ink splash effect.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text(
        'InkSparkle (M3)',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      const SizedBox(height: 16),
      Container(
        width: 160,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.purple.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Sparkle pattern
            ...List.generate(12, (i) {
              final radius = 30.0 + (i % 3) * 10;
              return Positioned(
                left: 80 + radius * 0.8 * (i % 2 == 0 ? 1 : -0.7),
                top: 50 + radius * 0.6 * (i % 3 == 0 ? 1 : -0.5),
                child: Container(
                  width: 4 + (i % 3) * 2.0,
                  height: 4 + (i % 3) * 2.0,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(200 - i * 15),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
            const Center(
              child: Icon(Icons.touch_app, color: Colors.white, size: 32),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text(
        'Particle-based splash animation',
        style: TextStyle(fontSize: 11, color: Colors.grey),
      ),
    ],
  );
}
