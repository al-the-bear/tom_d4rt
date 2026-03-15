import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PointerChange - pointer event types.
/// Demonstrates add, hover, down, move, up, remove events.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerChange Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pointer Changes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildChangeCard('add', 'Pointer enters proximity', Colors.green),
          _buildChangeCard('hover', 'Pointer moves (no contact)', Colors.blue),
          _buildChangeCard('down', 'Pointer starts contact', Colors.purple),
          _buildChangeCard('move', 'Pointer moves (in contact)', Colors.orange),
          _buildChangeCard('up', 'Pointer ends contact', Colors.pink),
          _buildChangeCard('remove', 'Pointer leaves proximity', Colors.red),
          _buildChangeCard('cancel', 'Gesture cancelled', Colors.grey),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('PointerChange describes the change in state for a pointer device interaction.'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildChangeCard(String name, String desc, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)]),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 16),
        Text('PointerChange.$name', style: const TextStyle(fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.w500)),
        const Spacer(),
        Text(desc, style: TextStyle(color: Colors.grey.shade700, fontSize: 11)),
      ],
    ),
  );
}
