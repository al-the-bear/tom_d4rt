import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for semantics hit test behavior.
/// Demonstrates translucent, opaque, and deferring behaviors.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Semantics HitTest')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Hit Test Behaviors', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildBehaviorCard('opaque', 'Absorbs all hits', 'Screen readers stop at this node', Colors.blue),
          _buildBehaviorCard('translucent', 'Allows hit pass-through', 'Siblings below can also receive focus', Colors.green),
          _buildBehaviorCard('deferToChild', 'Child controls absorption', 'Delegates to semantics children', Colors.orange),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Controls how accessibility focus traversal interacts with overlapping semantic nodes.'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildBehaviorCard(String name, String title, String desc, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)]),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 12),
          Text('HitTestBehavior.$name', style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
      ],
    ),
  );
}
