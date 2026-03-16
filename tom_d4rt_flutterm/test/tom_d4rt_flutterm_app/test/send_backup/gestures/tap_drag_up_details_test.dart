import 'package:flutter/material.dart';

/// Deep visual demo for TapDragUpDetails.
/// Shows pointer lift info in tap-drag sequence.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('TapDragUpDetails')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tap Drag Up Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fired when:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Pointer lifts after a tap (no drag occurred)'),
                Text('within TapAndDragGestureRecognizer.'),
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
                Text('Provides:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• globalPosition: Offset - Screen coords'),
                Text('• localPosition: Offset - Widget coords'),
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
                Icon(Icons.compare_arrows, color: Colors.amber),
                SizedBox(width: 8),
                Expanded(child: Text('Compare: TapDragEndDetails fires after drag, TapDragUpDetails fires after simple tap',
                  style: TextStyle(fontSize: 11))),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
