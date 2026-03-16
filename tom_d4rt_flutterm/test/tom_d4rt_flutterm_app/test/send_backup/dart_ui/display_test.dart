import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for Display - physical display information.
/// Demonstrates screen dimensions, pixel ratio, and refresh rate.
dynamic build(BuildContext context) {
  final view = View.of(context);
  final pixelRatio = view.devicePixelRatio;
  final physicalSize = view.physicalSize;
  final logicalSize = physicalSize / pixelRatio;
  
  return Scaffold(
    appBar: AppBar(title: const Text('Display Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Display Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildInfoCard('Physical Size', '${physicalSize.width.toInt()} x ${physicalSize.height.toInt()} px', Icons.tv, Colors.blue),
          const SizedBox(height: 12),
          _buildInfoCard('Logical Size', '${logicalSize.width.toInt()} x ${logicalSize.height.toInt()} dp', Icons.aspect_ratio, Colors.green),
          const SizedBox(height: 12),
          _buildInfoCard('Pixel Ratio', '${pixelRatio.toStringAsFixed(2)}x', Icons.photo_size_select_large, Colors.orange),
          const SizedBox(height: 12),
          _buildInfoCard('View ID', '${view.viewId}', Icons.numbers, Colors.purple),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
            child: const Text('Display class provides information about the physical screen and its properties.'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildInfoCard(String label, String value, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(border: Border.all(color: color.withValues(alpha: 0.5)), borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(width: 16),
        Expanded(child: Text(label)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontFamily: 'monospace')),
      ],
    ),
  );
}
