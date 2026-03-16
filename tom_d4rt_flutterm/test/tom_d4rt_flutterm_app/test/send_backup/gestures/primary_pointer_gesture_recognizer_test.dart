import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for PrimaryPointerGestureRecognizer.
/// Shows single-pointer gesture handling base class.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PrimaryPointerGestureRecognizer')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Primary Pointer Recognizer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Base class for:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• TapGestureRecognizer'),
                Text('• LongPressGestureRecognizer'),
                Text('• DoubleTapGestureRecognizer'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Key Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• deadline: Duration'),
                Text('  Time limit to recognize gesture'),
                SizedBox(height: 4),
                Text('• preAcceptSlopTolerance: double'),
                Text('  Movement allowed before rejection'),
                SizedBox(height: 4),
                Text('• postAcceptSlopTolerance: double'),
                Text('  Movement allowed after acceptance'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Tracks only the first pointer (ignores multitouch)',
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    ),
  );
}
