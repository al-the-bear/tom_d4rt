import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for gesture Class utilities.
/// Shows class-level gesture infrastructure.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Gesture Class Utilities')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Gesture Infrastructure',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _ClassBox(name: 'GestureRecognizer', desc: 'Base class'),
          _ClassBox(name: 'OneSequenceGestureRecognizer', desc: 'Single pointer sequence'),
          _ClassBox(name: 'MultiDragGestureRecognizer', desc: 'Multi-pointer drag'),
          _ClassBox(name: 'MultiTapGestureRecognizer', desc: 'Multi-tap detection'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Gesture library provides classes for detecting and handling various pointer interactions.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _ClassBox extends StatelessWidget {
  final String name;
  final String desc;
  const _ClassBox({required this.name, required this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        const Icon(Icons.class_, color: Colors.purple),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 12)),
              Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
        ),
      ]),
    );
  }
}
