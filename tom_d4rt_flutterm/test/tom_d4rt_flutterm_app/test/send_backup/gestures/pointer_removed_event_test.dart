import 'package:flutter/material.dart';

/// Deep visual demo for PointerRemovedEvent.
/// Shows when an input device is removed from the system.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerRemovedEvent')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('PointerRemovedEvent', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Icon(Icons.info_outline, color: Colors.amber), SizedBox(width: 8),
                  Text('When Fired', style: TextStyle(fontWeight: FontWeight.bold))]),
                SizedBox(height: 8),
                Text('• Stylus lifted from tablet'),
                Text('• Touch finger removed'),
                Text('• Mouse disconnected'),
              ],
            ),
          ),
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
                Text('Key Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• device: int - Which pointer was removed'),
                Text('• kind: PointerDeviceKind - touch/mouse/stylus'),
                Text('• position: Offset - Last known position'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Contrast with PointerAddedEvent which fires when device appears',
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    ),
  );
}
