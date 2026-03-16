import 'package:flutter/material.dart';

/// Deep visual demo for RangeSliderTrackShape.
/// Shape of the RangeSlider track.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RangeSliderTrackShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Column(
        children: [
          _TrackDemo('Rounded', 4, 4),
          const SizedBox(height: 12),
          _TrackDemo('Rectangular', 2, 8),
        ],
      ),
      const SizedBox(height: 12),
      const Text('RoundedRectRangeSliderTrackShape', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _TrackDemo extends StatelessWidget {
  final String label;
  final double radius;
  final double height;
  const _TrackDemo(this.label, this.radius, this.height);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 70, child: Text(label, style: const TextStyle(fontSize: 10))),
        Container(
          width: 120,
          height: height,
          child: Stack(
            children: [
              Container(decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(radius))),
              FractionallySizedBox(
                widthFactor: 0.6,
                alignment: const Alignment(-0.3, 0),
                child: Container(decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(radius))),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
