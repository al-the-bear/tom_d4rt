import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for ObjectCreated - memory allocation event.
/// Shows how object creation is tracked for leak detection.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ObjectCreated Event Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Object Creation Tracking',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const Icon(Icons.add_circle, color: Colors.green, size: 48),
                const SizedBox(height: 12),
                const Text('ObjectCreated', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 16),
                _EventField(label: 'object', value: 'AnimationController'),
                _EventField(label: 'library', value: 'package:flutter/animation.dart'),
                _EventField(label: 'className', value: 'AnimationController'),
                _EventField(label: 'timestamp', value: '2024-01-15T10:30:45.123'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('ObjectCreated events are dispatched when objects with memory tracking enabled are instantiated. Used for memory leak detection.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _EventField extends StatelessWidget {
  final String label;
  final String value;
  const _EventField({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        SizedBox(width: 80, child: Text('\$label:', style: const TextStyle(color: Colors.grey, fontSize: 12))),
        Expanded(child: Text(value, style: const TextStyle(fontFamily: 'monospace', fontSize: 11))),
      ]),
    );
  }
}
