import 'package:flutter/material.dart';

/// Deep visual demo for RectangularSliderTrackShape.
/// Rectangular track for Slider (sharp edges).
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RectangularSliderTrackShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _TrackDemo('Rounded', true),
          const SizedBox(width: 24),
          _TrackDemo('Rectangular', false),
        ],
      ),
      const SizedBox(height: 12),
      const Text('trackShape property', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _TrackDemo extends StatelessWidget {
  final String label;
  final bool rounded;
  const _TrackDemo(this.label, this.rounded);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 30,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: rounded ? BorderRadius.circular(2) : null)),
              Positioned(left: 0, right: 30, child: Container(height: 4, decoration: BoxDecoration(color: Colors.blue, borderRadius: rounded ? const BorderRadius.horizontal(left: Radius.circular(2)) : null))),
              Positioned(right: 25, child: Container(width: 14, height: 14, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
            ],
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
