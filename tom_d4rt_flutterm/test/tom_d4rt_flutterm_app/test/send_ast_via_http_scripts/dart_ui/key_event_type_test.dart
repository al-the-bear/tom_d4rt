import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for KeyEventType - types of keyboard events.
/// Demonstrates down, up, and repeat event types.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('KeyEventType Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Key Event Types', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildEventTimeline(),
          const SizedBox(height: 32),
          _buildTypeCard('down', 'Key pressed down', Colors.blue),
          _buildTypeCard('up', 'Key released', Colors.green),
          _buildTypeCard('repeat', 'Key held (auto-repeat)', Colors.orange),
        ],
      ),
    ),
  );
}

Widget _buildEventTimeline() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)),
    child: Column(
      children: [
        const Text('Key Press Timeline', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTimelineEvent('down', Colors.blue),
            Container(width: 40, height: 2, color: Colors.grey),
            _buildTimelineEvent('repeat', Colors.orange),
            Container(width: 20, height: 2, color: Colors.grey),
            _buildTimelineEvent('repeat', Colors.orange),
            Container(width: 20, height: 2, color: Colors.grey),
            _buildTimelineEvent('repeat', Colors.orange),
            Container(width: 40, height: 2, color: Colors.grey),
            _buildTimelineEvent('up', Colors.green),
          ],
        ),
      ],
    ),
  );
}

Widget _buildTimelineEvent(String label, Color color) {
  return Column(
    children: [
      Container(width: 24, height: 24, decoration: BoxDecoration(color: color, shape: BoxShape.circle), child: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16)),
      Text(label, style: TextStyle(fontSize: 9, color: color)),
    ],
  );
}

Widget _buildTypeCard(String name, String desc, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)]),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Container(width: 40, height: 40, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.keyboard, color: Colors.white)),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('KeyEventType.$name', style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
            Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          ],
        ),
      ],
    ),
  );
}
