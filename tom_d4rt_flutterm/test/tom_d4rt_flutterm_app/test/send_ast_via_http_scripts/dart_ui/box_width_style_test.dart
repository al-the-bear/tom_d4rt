import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for BoxWidthStyle - text selection box width styles.
/// Demonstrates tight vs max width styles for text boxes.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('BoxWidthStyle Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('BoxWidthStyle Values', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildStyleCard(
            'BoxWidthStyle.tight',
            'Width fits tightly around the content',
            Icons.compress,
            Colors.green,
            _buildTightDemo(),
          ),
          const SizedBox(height: 24),
          _buildStyleCard(
            'BoxWidthStyle.max',
            'Width extends to maximum available space',
            Icons.expand,
            Colors.orange,
            _buildMaxDemo(),
          ),
        ],
      ),
    ),
  );
}

Widget _buildStyleCard(String title, String desc, IconData icon, Color color, Widget demo) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: color.withValues(alpha: 0.5)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        demo,
      ],
    ),
  );
}

Widget _buildTightDemo() {
  return Container(
    color: Colors.green.withValues(alpha: 0.2),
    child: const Text('Tight', style: TextStyle(backgroundColor: Colors.green)),
  );
}

Widget _buildMaxDemo() {
  return Container(
    width: double.infinity,
    color: Colors.orange.withValues(alpha: 0.2),
    child: const Text('Max Width', style: TextStyle(backgroundColor: Colors.orange)),
  );
}
