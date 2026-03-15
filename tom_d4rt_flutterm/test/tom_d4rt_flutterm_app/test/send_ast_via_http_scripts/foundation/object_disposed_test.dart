import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for ObjectDisposed - memory deallocation event.
/// Shows how object disposal is tracked for leak detection.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ObjectDisposed Event Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Object Disposal Tracking',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const Icon(Icons.remove_circle, color: Colors.red, size: 48),
                const SizedBox(height: 12),
                const Text('ObjectDisposed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 16),
                _DisposeField(label: 'object', value: 'AnimationController'),
                _DisposeField(label: 'library', value: 'package:flutter/animation.dart'),
                _DisposeField(label: 'className', value: 'AnimationController'),
                _DisposeField(label: 'lifetime', value: '5.234 seconds'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(children: [
              Icon(Icons.warning, color: Colors.amber),
              SizedBox(width: 8),
              Expanded(child: Text('Missing ObjectDisposed events may indicate memory leaks!')),
            ]),
          ),
        ],
      ),
    ),
  );
}

class _DisposeField extends StatelessWidget {
  final String label;
  final String value;
  const _DisposeField({required this.label, required this.value});
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
