import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for KeyData - raw keyboard event information.
/// Demonstrates physical key, logical key, and character.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('KeyData Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('KeyData', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Raw keyboard event from platform', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.cyan.shade100]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(Icons.keyboard, size: 48),
                const SizedBox(height: 8),
                const Text('Press any key', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                _buildKeyInfo('physical', 'Physical key code on hardware'),
                _buildKeyInfo('logical', 'Logical key meaning'),
                _buildKeyInfo('character', 'Generated character (if any)'),
                _buildKeyInfo('type', 'down, up, or repeat'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.orange),
                SizedBox(width: 12),
                Expanded(child: Text('KeyData is low-level - use RawKeyEvent for most cases')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildKeyInfo(String name, String desc) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Row(
      children: [
        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
        const SizedBox(width: 12),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
        const SizedBox(width: 8),
        Expanded(child: Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 11))),
      ],
    ),
  );
}
