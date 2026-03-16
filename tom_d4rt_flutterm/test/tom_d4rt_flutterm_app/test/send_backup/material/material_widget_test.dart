import 'package:flutter/material.dart';

/// Deep visual demo for Material widget.
/// The foundational widget for Material Design surfaces.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Material Widget', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _MaterialDemo('Elevation 0', 0),
          const SizedBox(width: 12),
          _MaterialDemo('Elevation 4', 4),
          const SizedBox(width: 12),
          _MaterialDemo('Elevation 8', 8),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('Provides elevation, shape, color, ink', style: TextStyle(fontSize: 10)),
      ),
    ],
  );
}

class _MaterialDemo extends StatelessWidget {
  final String label;
  final double elevation;
  const _MaterialDemo(this.label, this.elevation);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((elevation * 10).toInt()),
                blurRadius: elevation * 2,
                offset: Offset(0, elevation),
              ),
            ],
          ),
          child: const Icon(Icons.layers, color: Colors.blue),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
