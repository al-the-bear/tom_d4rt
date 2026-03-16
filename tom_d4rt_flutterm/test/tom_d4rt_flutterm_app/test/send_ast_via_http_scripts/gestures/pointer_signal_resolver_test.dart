import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for PointerSignalResolver.
/// Shows how competing scroll handlers are resolved.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerSignalResolver')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Signal Resolution', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                Text('Purpose:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('When multiple widgets want to handle a scroll event, '
                  'PointerSignalResolver determines the winner.'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Visual hierarchy diagram
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Text('Nested ScrollViews', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red.shade100,
                  child: Column(
                    children: [
                      const Text('Outer ListView', style: TextStyle(fontSize: 11)),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        color: Colors.green.shade100,
                        child: const Column(
                          children: [
                            Text('Inner ListView', style: TextStyle(fontSize: 11)),
                            Icon(Icons.arrow_upward, size: 16),
                            Text('Winner via', style: TextStyle(fontSize: 9)),
                            Text('resolver.register()', style: TextStyle(fontSize: 9)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('First to register wins the scroll event', style: TextStyle(color: Colors.grey)),
        ],
      ),
    ),
  );
}
