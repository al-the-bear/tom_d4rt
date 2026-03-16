import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for HitTestable interface.
/// Shows hit testing contract for render objects.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('HitTestable')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('HitTestable Interface',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('abstract interface HitTestable {', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                SizedBox(height: 8),
                Text('  void hitTest(', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                Text('    BoxHitTestResult result,', style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.teal)),
                Text('    Offset position,', style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.teal)),
                Text('  );', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                SizedBox(height: 8),
                Text('}', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Objects implementing HitTestable can determine if a position is within their bounds and add themselves to hit test results.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}
