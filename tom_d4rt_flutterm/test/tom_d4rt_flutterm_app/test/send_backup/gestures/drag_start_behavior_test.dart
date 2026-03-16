import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DragStartBehavior enum.
/// Shows when drag position is calculated.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DragStartBehavior')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Drag Start Behavior',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _BehaviorCard(
            behavior: 'down',
            desc: 'Position from initial touch',
            details: 'Start position is where finger first touched',
            color: Colors.blue,
          ),
          _BehaviorCard(
            behavior: 'start',
            desc: 'Position when drag accepted',
            details: 'Start position is where gesture was recognized',
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(children: [
              Icon(Icons.info_outline, color: Colors.amber),
              SizedBox(width: 8),
              Expanded(child: Text('Affects initial delta calculation in drag callbacks.')),
            ]),
          ),
        ],
      ),
    ),
  );
}

class _BehaviorCard extends StatelessWidget {
  final String behavior;
  final String desc;
  final String details;
  final Color color;
  const _BehaviorCard({required this.behavior, required this.desc, required this.details, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: color)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
              child: Text(behavior, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Text(desc, style: const TextStyle(fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 8),
          Text(details, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
