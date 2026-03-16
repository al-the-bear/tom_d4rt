import 'package:flutter/material.dart';

/// Deep visual demo for TapDragEndDetails.
/// Shows end info for tap-drag gesture.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('TapDragEndDetails')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tap Drag End Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                Row(children: [Icon(Icons.stop_circle_outlined, color: Colors.red), SizedBox(width: 8),
                  Text('End Conditions', style: TextStyle(fontWeight: FontWeight.bold))]),
                SizedBox(height: 8),
                Text('• Pointer lifted after drag'),
                Text('• Gesture cancelled'),
                Text('• Arena gives up'),
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
                Text('• velocity: Velocity'),
                Text('  How fast pointer was moving'),
                SizedBox(height: 4),
                Text('• primaryVelocity: double?'),
                Text('  Velocity on primary axis'),
                SizedBox(height: 4),
                Text('• consecutiveTapCount: int'),
                Text('  How many taps in sequence'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Center(child: Text('Use velocity for fling behavior', style: TextStyle(color: Colors.grey))),
        ],
      ),
    ),
  );
}
