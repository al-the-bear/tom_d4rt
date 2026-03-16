import 'package:flutter/material.dart';

/// Deep visual demo for ScrollbarThemeData.
/// Theme data for customizing scrollbar appearance.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ScrollbarThemeData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ScrollbarDemo('Default', Colors.grey.shade400, 4, 2),
          const SizedBox(width: 16),
          _ScrollbarDemo('Thick', Colors.blue, 8, 4),
          const SizedBox(width: 16),
          _ScrollbarDemo('Square', Colors.purple, 6, 0),
        ],
      ),
      const SizedBox(height: 12),
      const Text('thickness, thumbColor, radius, crossAxisMargin', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _ScrollbarDemo extends StatelessWidget {
  final String label;
  final Color color;
  final double thickness;
  final double radius;
  const _ScrollbarDemo(this.label, this.color, this.thickness, this.radius);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 60,
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)),
          child: Stack(
            children: [
              Positioned(
                right: 2,
                top: 8,
                child: Container(
                  width: thickness,
                  height: 24,
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(radius)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
