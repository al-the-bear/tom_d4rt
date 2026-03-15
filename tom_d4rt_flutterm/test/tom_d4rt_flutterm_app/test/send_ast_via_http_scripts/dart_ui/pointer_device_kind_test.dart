import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PointerDeviceKind - input device types.
/// Demonstrates touch, mouse, stylus, trackpad, and unknown.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerDeviceKind Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pointer Device Kinds', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildDeviceCard('touch', 'Finger touch', Icons.touch_app, Colors.blue),
          _buildDeviceCard('mouse', 'Mouse pointer', Icons.mouse, Colors.green),
          _buildDeviceCard('stylus', 'Pen/stylus input', Icons.edit, Colors.purple),
          _buildDeviceCard('invertedStylus', 'Eraser end', Icons.auto_fix_off, Colors.orange),
          _buildDeviceCard('trackpad', 'Trackpad gesture', Icons.gesture, Colors.pink),
          _buildDeviceCard('unknown', 'Unidentified', Icons.help_outline, Colors.grey),
        ],
      ),
    ),
  );
}

Widget _buildDeviceCard(String name, String desc, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)]),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PointerDeviceKind.$name', style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
              Text(desc, style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    ),
  );
}
