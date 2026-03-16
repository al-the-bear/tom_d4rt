import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ImmutableBuffer - efficient byte storage.
/// Demonstrates immutable buffer for image and asset data.
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
          const Text('Efficient immutable byte storage', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildFeatureCard('Memory Efficient', 'Shares memory without copying', Icons.memory, Colors.blue),
          const SizedBox(height: 12),
          _buildFeatureCard('Immutable', 'Cannot be modified after creation', Icons.lock, Colors.green),
          const SizedBox(height: 12),
          _buildFeatureCard('Asset Loading', 'Optimal for loading assets', Icons.folder_open, Colors.orange),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Creation Methods:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• ImmutableBuffer.fromUint8List(bytes)', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                Text('• ImmutableBuffer.fromAsset(key)', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                Text('• ImmutableBuffer.fromFilePath(path)', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildFeatureCard(String title, String desc, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: color.withValues(alpha: 0.5)),
      borderRadius: BorderRadius.circular(12),
      color: color.withValues(alpha: 0.05),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}
