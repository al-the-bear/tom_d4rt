import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for FilterQuality - image scaling quality levels.
/// Demonstrates none, low, medium, and high filter quality.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('FilterQuality Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Filter Quality Levels', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildQualityDemo(FilterQuality.none, 'none', 'Nearest neighbor (fastest)', Colors.red),
                _buildQualityDemo(FilterQuality.low, 'low', 'Bilinear interpolation', Colors.orange),
                _buildQualityDemo(FilterQuality.medium, 'medium', 'Bilinear + mipmaps', Colors.blue),
                _buildQualityDemo(FilterQuality.high, 'high', 'Bicubic (slowest)', Colors.green),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildQualityDemo(FilterQuality quality, String name, String desc, Color color) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.image, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 12),
        Text('FilterQuality.$name', style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)),
        const SizedBox(height: 4),
        Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey.shade600), textAlign: TextAlign.center),
      ],
    ),
  );
}
