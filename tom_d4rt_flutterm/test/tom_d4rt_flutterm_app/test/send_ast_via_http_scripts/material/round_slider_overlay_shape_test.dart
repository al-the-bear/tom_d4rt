import 'package:flutter/material.dart';

/// Deep visual demo for RoundSliderOverlayShape.
/// Circular overlay shown when slider thumb is pressed.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RoundSliderOverlayShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _OverlayDemo('Default', 12, 24),
          const SizedBox(width: 24),
          _OverlayDemo('Large', 12, 36),
        ],
      ),
      const SizedBox(height: 12),
      const Text('overlayRadius property', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _OverlayDemo extends StatelessWidget {
  final String label;
  final double thumbRadius;
  final double overlayRadius;
  const _OverlayDemo(this.label, this.thumbRadius, this.overlayRadius);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: overlayRadius * 2,
              height: overlayRadius * 2,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue.withAlpha(50)),
            ),
            Container(
              width: thumbRadius * 2,
              height: thumbRadius * 2,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
