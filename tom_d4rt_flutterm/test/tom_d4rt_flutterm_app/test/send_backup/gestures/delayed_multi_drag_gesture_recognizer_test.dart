import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DelayedMultiDragGestureRecognizer.
/// Shows multi-pointer drag with delay before acceptance.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DelayedMultiDragGestureRecognizer')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Delayed Multi-Pointer Drag',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _PhaseCard(phase: 1, title: 'Touch Down', desc: 'Timer starts', duration: '150ms'),
          _PhaseCard(phase: 2, title: 'Delay Period', desc: 'Waiting...', duration: '→'),
          _PhaseCard(phase: 3, title: 'Accepted', desc: 'Drag begins', duration: null),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(children: [
              Icon(Icons.timer, color: Colors.amber),
              SizedBox(width: 8),
              Expanded(child: Text('Waits before accepting to allow scrolling containers to handle first.')),
            ]),
          ),
        ],
      ),
    ),
  );
}

class _PhaseCard extends StatelessWidget {
  final int phase;
  final String title;
  final String desc;
  final String? duration;
  const _PhaseCard({required this.phase, required this.title, required this.desc, this.duration});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Container(
          width: 32, height: 32,
          decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
          child: Center(child: Text('\$phase', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
        if (duration != null) Text(duration!, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
      ]),
    );
  }
}
