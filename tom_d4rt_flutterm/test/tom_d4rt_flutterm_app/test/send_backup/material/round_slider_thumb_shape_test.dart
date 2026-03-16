import 'package:flutter/material.dart';

/// Deep visual demo for RoundSliderThumbShape.
/// Default circular thumb shape for Slider.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RoundSliderThumbShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ThumbDemo('Small', 8, 4),
          const SizedBox(width: 16),
          _ThumbDemo('Default', 10, 6),
          const SizedBox(width: 16),
          _ThumbDemo('Large', 14, 8),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 30,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            Positioned(left: 0, right: 80, child: Container(height: 4, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2)))),
            Positioned(right: 75, child: Container(width: 20, height: 20, decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]))),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('enabledThumbRadius, disabledThumbRadius', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ThumbDemo extends StatelessWidget {
  final String label;
  final double enabled;
  final double disabled;
  const _ThumbDemo(this.label, this.enabled, this.disabled);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(width: enabled * 2, height: enabled * 2, decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 2)])),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
