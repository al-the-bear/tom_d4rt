import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PictureRasterizationException.
/// Demonstrates rasterization error scenarios.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PictureRasterizationException'), titleTextStyle: const TextStyle(fontSize: 14)),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Picture Rasterization Exception', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Icon(Icons.error, color: Colors.red.shade700, size: 40),
                const SizedBox(width: 16),
                const Expanded(child: Text('Thrown when Picture.toImage fails due to GPU resource limits.', style: TextStyle(fontWeight: FontWeight.w500))),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Common Causes:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildCause('Oversized images', 'Picture too large for GPU memory'),
          _buildCause('Invalid dimensions', 'Zero or negative size'),
          _buildCause('Resource exhaustion', 'Too many textures allocated'),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text(
              'Catch this exception when using Picture.toImage() or toImageSync().',
              style: TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCause(String title, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(Icons.warning_amber, color: Colors.orange.shade700, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}
