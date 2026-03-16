import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for Color.fromARGB - ARGB color creation.
/// Demonstrates color construction with alpha, red, green, blue components.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Color.fromARGB Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Color Construction', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildColorDemo('fromARGB(255, 255, 0, 0)', const Color.fromARGB(255, 255, 0, 0)),
          _buildColorDemo('fromARGB(255, 0, 255, 0)', const Color.fromARGB(255, 0, 255, 0)),
          _buildColorDemo('fromARGB(255, 0, 0, 255)', const Color.fromARGB(255, 0, 0, 255)),
          _buildColorDemo('fromARGB(128, 255, 0, 0)', const Color.fromARGB(128, 255, 0, 0)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Color Components:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _buildComponent('A (Alpha)', '0-255', 'Transparency'),
                _buildComponent('R (Red)', '0-255', 'Red intensity'),
                _buildComponent('G (Green)', '0-255', 'Green intensity'),
                _buildComponent('B (Blue)', '0-255', 'Blue intensity'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildColorDemo(String code, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(width: 60, height: 60, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade400))),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Color.$code', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text('A:${color.a.toInt()} R:${color.r.toInt()} G:${color.g.toInt()} B:${color.b.toInt()}', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildComponent(String name, String range, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(width: 100, child: Text(name, style: const TextStyle(fontWeight: FontWeight.w500))),
        SizedBox(width: 60, child: Text(range, style: const TextStyle(fontFamily: 'monospace'))),
        Text(desc, style: TextStyle(color: Colors.grey.shade600)),
      ],
    ),
  );
}
