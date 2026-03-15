import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for EagerGestureRecognizer.
/// Shows recognizer that wins gesture arena immediately.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('EagerGestureRecognizer')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Eager Gesture Recognition',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const Icon(Icons.flash_on, size: 48, color: Colors.red),
                const SizedBox(height: 12),
                const Text('Wins Arena Immediately', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                const SizedBox(height: 8),
                const Text('Does not wait for other recognizers', style: TextStyle(fontSize: 12)),
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
              Expanded(child: Text('Use cautiously - prevents other gestures from competing')),
            ]),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Useful for modal barriers or exclusive touch handling areas.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}
