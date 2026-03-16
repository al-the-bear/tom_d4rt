import 'package:flutter/material.dart';

/// Deep visual demo for VisualDensity class.
/// Visual density configuration for components.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('VisualDensity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _DensityDemo('Compact', -4, -4),
          const SizedBox(width: 8),
          _DensityDemo('Standard', 0, 0),
          const SizedBox(width: 8),
          _DensityDemo('Comfortable', 4, 4),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
        child: const Column(
          children: [
            Text('horizontal: double', style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
            Text('vertical: double', style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
            SizedBox(height: 4),
            Text('Range: -4.0 to 4.0', style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    ],
  );
}

class _DensityDemo extends StatelessWidget {
  final String name;
  final double h;
  final double v;
  const _DensityDemo(this.name, this.h, this.v);
  @override
  Widget build(BuildContext context) {
    final padding = 8.0 + (v / 2);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12 + (h / 2), vertical: padding),
          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(4)),
          child: const Text('Button', style: TextStyle(color: Colors.white, fontSize: 10)),
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 9)),
        Text('(\${h.toInt()}, \${v.toInt()})', style: const TextStyle(fontFamily: 'monospace', fontSize: 8, color: Colors.grey)),
      ],
    );
  }
}
