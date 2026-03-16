import 'package:flutter/material.dart';

/// Deep visual demo for TapMoveDetails.
/// Shows movement during tap-down state.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('TapMoveDetails')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tap Move Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Purpose:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Track small movements while pointer is down,'),
                Text('before deciding if it becomes a drag.'),
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
                Text('• delta: Offset (movement since last event)'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.amber),
                SizedBox(width: 8),
                Expanded(child: Text('Movement within slop tolerance keeps it a tap; exceeding converts to drag',
                  style: TextStyle(fontSize: 11))),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
