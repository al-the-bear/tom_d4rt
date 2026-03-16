import 'package:flutter/material.dart';

/// Deep visual demo for Chip widgets in Wrap layout.
/// Multiple chips flowing in wrapped layout.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Wrapped Chips', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _TagChip('Flutter', Colors.blue),
            _TagChip('Dart', Colors.teal),
            _TagChip('Mobile', Colors.green),
            _TagChip('Web', Colors.orange),
            _TagChip('Desktop', Colors.purple),
            _TagChip('Cross-platform', Colors.pink),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Wrap widget with Chip children', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _TagChip extends StatelessWidget {
  final String label;
  final Color color;
  const _TagChip(this.label, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color.withAlpha(50), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withAlpha(100))),
      child: Text(label, style: TextStyle(color: color.shade700, fontSize: 10)),
    );
  }
}

extension on Color {
  Color get shade700 => HSLColor.fromColor(this).withLightness(0.35).toColor();
}
