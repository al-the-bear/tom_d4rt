import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for MultitouchDragStrategy enum.
/// Shows how multi-touch affects drag.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('MultitouchDragStrategy')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Multitouch Drag Strategy',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _StrategyCard(
            name: 'latestPointer',
            desc: 'Use most recent touch only',
            icon: Icons.touch_app,
            color: Colors.blue,
          ),
          _StrategyCard(
            name: 'averageBoundaryPointers',
            desc: 'Average of boundary pointers',
            icon: Icons.multiple_stop,
            color: Colors.green,
          ),
          _StrategyCard(
            name: 'sumAllPointers',
            desc: 'Sum deltas of all pointers',
            icon: Icons.add_circle,
            color: Colors.orange,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Determines how multiple simultaneous touches affect the reported drag delta.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _StrategyCard extends StatelessWidget {
  final String name;
  final String desc;
  final IconData icon;
  final Color color;
  const _StrategyCard({required this.name, required this.desc, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
      child: Row(children: [
        Icon(icon, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontFamily: 'monospace')),
              Text(desc, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ]),
    );
  }
}
