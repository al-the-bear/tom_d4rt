import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DragStartDetails.
/// Shows details when drag gesture starts.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DragStartDetails')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Drag Start Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(children: [
                  Icon(Icons.play_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text('onDragStart', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                ]),
                const SizedBox(height: 16),
                _DetailField(name: 'globalPosition', value: 'Offset(156.0, 234.0)'),
                _DetailField(name: 'localPosition', value: 'Offset(100.0, 150.0)'),
                _DetailField(name: 'sourceTimeStamp', value: 'Duration(0:00:01.234567)'),
                _DetailField(name: 'kind', value: 'PointerDeviceKind.touch'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('DragStartDetails is passed to onPanStart, onHorizontalDragStart, and onVerticalDragStart callbacks.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _DetailField extends StatelessWidget {
  final String name;
  final String value;
  const _DetailField({required this.name, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        SizedBox(width: 120, child: Text('\$name:', style: const TextStyle(color: Colors.grey, fontSize: 12))),
        Expanded(child: Text(value, style: const TextStyle(fontFamily: 'monospace', fontSize: 11))),
      ]),
    );
  }
}
