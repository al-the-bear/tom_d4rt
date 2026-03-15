import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ColorSpace - color space representations.
/// Demonstrates sRGB and display P3 color spaces.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ColorSpace Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Color Spaces', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Different color gamuts for rendering', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildColorSpaceCard('ColorSpace.sRGB', 'Standard RGB', 'Default web/display color space', Colors.blue, [Colors.red, Colors.green, Colors.blue]),
          const SizedBox(height: 16),
          _buildColorSpaceCard('ColorSpace.displayP3', 'Display P3', 'Wide gamut color space', Colors.purple, [const Color(0xFFFF0000), const Color(0xFF00FF00), const Color(0xFF0000FF)]),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.lightbulb_outline, color: Colors.amber),
                const SizedBox(width: 12),
                const Expanded(child: Text('Display P3 has 25% more colors than sRGB')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildColorSpaceCard(String code, String name, String desc, Color accent, List<Color> gamut) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: accent.withValues(alpha: 0.5)),
      borderRadius: BorderRadius.circular(12),
      color: accent.withValues(alpha: 0.05),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(code, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
        Text(name, style: TextStyle(color: accent, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        const SizedBox(height: 12),
        Row(
          children: [
            const Text('Gamut: ', style: TextStyle(fontSize: 12)),
            ...gamut.map((c) => Container(width: 24, height: 24, margin: const EdgeInsets.only(right: 4), color: c)),
          ],
        ),
      ],
    ),
  );
}
