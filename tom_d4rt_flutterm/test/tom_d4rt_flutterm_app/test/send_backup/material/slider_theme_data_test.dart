import 'package:flutter/material.dart';

/// Deep visual demo for SliderThemeData.
/// Theme customization for Slider appearance.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SliderThemeData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ThemeDemo('Default', Colors.blue, 10, 4),
          const SizedBox(width: 16),
          _ThemeDemo('Custom', Colors.purple, 14, 8),
        ],
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        alignment: WrapAlignment.center,
        children: [
          _PropChip('thumbColor'),
          _PropChip('activeTrackColor'),
          _PropChip('trackHeight'),
          _PropChip('thumbShape'),
        ],
      ),
    ],
  );
}

class _ThemeDemo extends StatelessWidget {
  final String label;
  final Color color;
  final double thumbRadius;
  final double trackHeight;
  const _ThemeDemo(this.label, this.color, this.thumbRadius, this.trackHeight);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 40,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(height: trackHeight, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(trackHeight / 2))),
              Positioned(left: 0, right: 30, child: Container(height: trackHeight, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(trackHeight / 2)))),
              Positioned(right: 25, child: Container(width: thumbRadius * 2, height: thumbRadius * 2, decoration: BoxDecoration(color: color, shape: BoxShape.circle))),
            ],
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}

class _PropChip extends StatelessWidget {
  final String prop;
  const _PropChip(this.prop);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
      child: Text(prop, style: const TextStyle(fontFamily: 'monospace', fontSize: 8)),
    );
  }
}
