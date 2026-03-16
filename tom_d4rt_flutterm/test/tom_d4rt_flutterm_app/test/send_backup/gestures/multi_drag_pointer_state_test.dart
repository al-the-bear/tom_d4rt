import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for MultiDragPointerState.
/// Shows per-pointer state in multi-drag.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('MultiDragPointerState')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Per-Pointer Drag State',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _PointerStateCard(id: 1, state: 'active', position: '(100, 150)'),
          _PointerStateCard(id: 2, state: 'pending', position: '(200, 180)'),
          _PointerStateCard(id: 3, state: 'rejected', position: '(150, 220)'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• initialPosition - where pointer went down'),
                Text('• pendingDelta - accumulated movement'),
                Text('• client - the Drag object receiving events'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _PointerStateCard extends StatelessWidget {
  final int id;
  final String state;
  final String position;
  const _PointerStateCard({required this.id, required this.state, required this.position});
  @override
  Widget build(BuildContext context) {
    final color = state == 'active' ? Colors.green : state == 'pending' ? Colors.orange : Colors.grey;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
      child: Row(children: [
        Container(
          width: 32, height: 32,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(child: Text('\$id', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pointer \$id', style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('Position: \$position', style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
          child: Text(state.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
        ),
      ]),
    );
  }
}
