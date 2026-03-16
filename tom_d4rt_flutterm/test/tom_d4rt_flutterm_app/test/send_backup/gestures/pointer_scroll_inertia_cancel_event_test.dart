import 'package:flutter/material.dart';

/// Deep visual demo for PointerScrollInertiaCancelEvent.
/// Shows when scroll momentum is cancelled.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerScrollInertiaCancelEvent')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Scroll Inertia Cancel', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Icon(Icons.cancel, color: Colors.orange), SizedBox(width: 8),
                  Text('When Fired', style: TextStyle(fontWeight: FontWeight.bold))]),
                SizedBox(height: 8),
                Text('• User touches during fling scroll'),
                Text('• Scroll momentum interrupted'),
                Text('• New scroll gesture begins'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Typical Flow:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('1. PointerScrollEvent (wheel/trackpad)'),
                Text('2. Inertia/momentum scroll begins'),
                Text('3. User interrupts → PointerScrollInertiaCancelEvent'),
                Text('4. Momentum stops immediately'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Common in: ListView, PageView, CustomScrollView',
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    ),
  );
}
