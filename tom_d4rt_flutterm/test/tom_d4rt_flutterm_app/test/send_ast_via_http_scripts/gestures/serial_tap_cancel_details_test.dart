import 'package:flutter/material.dart';

/// Deep visual demo for SerialTapCancelDetails.
/// Shows info when a serial tap is cancelled.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('SerialTapCancelDetails')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Serial Tap Cancel', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Icon(Icons.cancel, color: Colors.red), SizedBox(width: 8),
                  Text('When Fired', style: TextStyle(fontWeight: FontWeight.bold))]),
                SizedBox(height: 8),
                Text('• User moved finger too much'),
                Text('• Tap timeout exceeded'),
                Text('• Gesture arena lost to another recognizer'),
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
                Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• count: int'),
                Text('  Number of taps before cancel'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Used with SerialTapGestureRecognizer for triple+ taps',
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    ),
  );
}
