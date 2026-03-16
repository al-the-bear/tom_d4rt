import 'package:flutter/material.dart';

/// Deep visual demo for TapDragDownDetails.
/// Shows initial contact info for tap-drag.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('TapDragDownDetails')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tap Drag Down Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fired when:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Pointer first touches down during'),
                Text('a TapAndDragGestureRecognizer sequence.'),
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
                Text('• globalPosition: Offset'),
                Text('• localPosition: Offset'),
                Text('• kind: PointerDeviceKind'),
                Text('• consecutiveTapCount: int'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(
              children: [
                Icon(Icons.info_outline, size: 18, color: Colors.amber),
                SizedBox(width: 8),
                Expanded(child: Text('consecutiveTapCount tracks rapid taps (double, triple...)',
                  style: TextStyle(fontSize: 12))),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
