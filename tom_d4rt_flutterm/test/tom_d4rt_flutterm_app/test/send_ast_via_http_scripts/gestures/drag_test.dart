import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for Drag interface.
/// Shows drag interface for drag gesture handling.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Drag Interface')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Drag Interface',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('interface Drag {', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                const SizedBox(height: 8),
                _MethodRow(method: 'update(DragUpdateDetails)'),
                _MethodRow(method: 'end(DragEndDetails)'),
                _MethodRow(method: 'cancel()'),
                const SizedBox(height: 8),
                const Text('}', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text('Drag interface is implemented by objects that receive drag events from MultiDragGestureRecognizer.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _MethodRow extends StatelessWidget {
  final String method;
  const _MethodRow({required this.method});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
      child: Text('void \$method;', style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.purple)),
    );
  }
}
