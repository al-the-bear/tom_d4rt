import 'package:flutter/material.dart';

/// Deep visual demo for RoundRangeSliderThumbShape.
/// Default circular thumb shape for RangeSlider.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RoundRangeSliderThumbShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ThumbSizeDemo('Small', 8),
          const SizedBox(width: 16),
          _ThumbSizeDemo('Default', 10),
          const SizedBox(width: 16),
          _ThumbSizeDemo('Large', 14),
        ],
      ),
      const SizedBox(height: 12),
      const Text('enabledThumbRadius property', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ThumbSizeDemo extends StatelessWidget {
  final String label;
  final double radius;
  const _ThumbSizeDemo(this.label, this.radius);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
