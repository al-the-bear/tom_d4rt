import 'package:flutter/material.dart';

/// Deep visual demo for VerticalDivider widget.
/// Vertical line that separates content.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('VerticalDivider', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _DividerDemo('Default', 1, 16, Colors.grey),
          const SizedBox(width: 24),
          _DividerDemo('Thick', 4, 16, Colors.blue),
          const SizedBox(width: 24),
          _DividerDemo('Indented', 1, 8, Colors.grey),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.font_download, size: 18),
            Container(width: 1, height: 24, margin: const EdgeInsets.symmetric(horizontal: 12), color: Colors.grey.shade400),
            const Icon(Icons.format_size, size: 18),
            Container(width: 1, height: 24, margin: const EdgeInsets.symmetric(horizontal: 12), color: Colors.grey.shade400),
            const Icon(Icons.text_fields, size: 18),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('width, thickness, indent, endIndent, color', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _DividerDemo extends StatelessWidget {
  final String label;
  final double thickness;
  final double indent;
  final Color color;
  const _DividerDemo(this.label, this.thickness, this.indent, this.color);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          child: Row(
            children: [
              const Text('A', style: TextStyle(fontSize: 14)),
              Container(width: thickness, height: 50 - indent * 2, margin: EdgeInsets.symmetric(horizontal: 8, vertical: indent), color: color),
              const Text('B', style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
