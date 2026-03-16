import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PointerDataPacket - batch of pointer events.
/// Demonstrates packet structure with multiple PointerData items.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerDataPacket Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pointer Data Packet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Batch of pointer events from platform', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('PointerDataPacket', style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, color: Colors.blue)),
                const SizedBox(height: 12),
                _buildEventItem(0, 'down', '(100, 200)'),
                _buildEventItem(1, 'move', '(105, 210)'),
                _buildEventItem(2, 'move', '(110, 220)'),
                _buildEventItem(3, 'up', '(110, 220)'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(
              children: [
                Icon(Icons.info, color: Colors.orange),
                SizedBox(width: 12),
                Expanded(child: Text('Events are batched for efficiency. Packets arrive via PlatformDispatcher.onPointerDataPacket')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildEventItem(int index, String change, String position) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(6)),
    child: Row(
      children: [
        CircleAvatar(radius: 12, backgroundColor: Colors.blue, child: Text('$index', style: const TextStyle(color: Colors.white, fontSize: 10))),
        const SizedBox(width: 12),
        Text('$change at $position', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
      ],
    ),
  );
}
