import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PointerSignalKind - pointer signal types.
/// Demonstrates scroll, scale, and stylus auxiliary signals.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerSignalKind Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pointer Signal Kinds', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Non-positional pointer signals', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildSignalCard('none', 'No signal', Icons.block, Colors.grey),
          _buildSignalCard('scroll', 'Scroll wheel motion', Icons.mouse, Colors.blue),
          _buildSignalCard('scrollInertiaCancel', 'Stop inertial scroll', Icons.pan_tool, Colors.orange),
          _buildSignalCard('scale', 'Trackpad pinch/zoom', Icons.zoom_out_map, Colors.green),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text('Pointer signals convey non-positional information like scroll deltas or scale factors.'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildSignalCard(String name, String desc, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(border: Border.all(color: color.withValues(alpha: 0.5)), borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PointerSignalKind.$name', style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 12)),
              Text(desc, style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    ),
  );
}
