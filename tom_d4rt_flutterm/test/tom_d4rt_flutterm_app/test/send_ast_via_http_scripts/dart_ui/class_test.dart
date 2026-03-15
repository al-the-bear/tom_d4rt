import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for dart:ui Class type - representation of classes in dart:ui.
/// Demonstrates concept of class introspection in dart:ui layer.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('dart:ui Classes Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('dart:ui Core Classes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildClassCard('Canvas', 'Drawing operations', Icons.brush, Colors.blue),
                _buildClassCard('Paint', 'Style settings', Icons.format_paint, Colors.purple),
                _buildClassCard('Path', 'Vector shapes', Icons.timeline, Colors.green),
                _buildClassCard('Picture', 'Recorded drawing', Icons.image, Colors.orange),
                _buildClassCard('Offset', '2D position', Icons.location_on, Colors.red),
                _buildClassCard('Rect', 'Rectangle bounds', Icons.crop_square, Colors.teal),
                _buildClassCard('Color', 'ARGB color', Icons.color_lens, Colors.pink),
                _buildClassCard('Size', 'Width & height', Icons.aspect_ratio, Colors.indigo),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildClassCard(String name, String desc, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
      ],
    ),
  );
}
