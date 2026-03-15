import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for OneSequenceGestureRecognizer.
/// Shows single-pointer sequence gesture handling.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('OneSequenceGestureRecognizer')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('One Sequence Recognizer',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              children: [
                Icon(Icons.gesture, size: 48, color: Colors.indigo),
                SizedBox(height: 12),
                Text('Single Pointer Tracking', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Handles one pointer from down to up', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Subclasses:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• TapGestureRecognizer'),
                Text('• DragGestureRecognizer'),
                Text('• LongPressGestureRecognizer'),
                Text('• ScaleGestureRecognizer'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text('Only tracks one gesture sequence at a time. Additional pointers are ignored or used for multi-touch.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}
