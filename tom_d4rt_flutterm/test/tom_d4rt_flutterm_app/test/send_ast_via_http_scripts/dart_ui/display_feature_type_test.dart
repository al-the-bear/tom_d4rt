import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for DisplayFeatureType - types of display features.
/// Demonstrates hinge, fold, and cutout feature types.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DisplayFeatureType Demo')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Display Feature Types', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildTypeDemo(
          'DisplayFeatureType.hinge',
          'Physical hardware hinge',
          'Connects two display panels that can fold',
          Icons.compare_arrows,
          Colors.blue,
        ),
        const SizedBox(height: 16),
        _buildTypeDemo(
          'DisplayFeatureType.fold',
          'Flexible fold area',
          'Part of display that bends when folding',
          Icons.crop_landscape,
          Colors.green,
        ),
        const SizedBox(height: 16),
        _buildTypeDemo(
          'DisplayFeatureType.cutout',
          'Screen cutout',
          'Area for camera, sensors, or speakers',
          Icons.camera_front,
          Colors.orange,
        ),
      ],
    ),
  );
}

Widget _buildTypeDemo(String code, String name, String desc, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)]),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
                  Text(desc, style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Text(code, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
        ),
      ],
    ),
  );
}
