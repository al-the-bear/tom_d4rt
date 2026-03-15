import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ImmutableBuffer - read-only byte buffer.
/// Demonstrates efficient asset loading without copying.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ImmutableBuffer Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ImmutableBuffer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Efficient read-only byte storage', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildFeature('Zero-copy', 'No memory duplication', Icons.flash_on, Colors.blue),
          _buildFeature('Immutable', 'Cannot be modified', Icons.lock, Colors.green),
          _buildFeature('Fast loading', 'Optimized for assets', Icons.speed, Colors.orange),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Creation methods:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('ImmutableBuffer.fromUint8List(bytes)', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                Text('ImmutableBuffer.fromAsset(assetKey)', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                Text('ImmutableBuffer.fromFilePath(path)', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: const [
                Icon(Icons.info_outline, color: Colors.blue),
                SizedBox(width: 12),
                Expanded(child: Text('Property: length - number of bytes in buffer', style: TextStyle(fontSize: 12))),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildFeature(String title, String desc, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(border: Border.all(color: color.withValues(alpha: 0.5)), borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          ],
        ),
      ],
    ),
  );
}
