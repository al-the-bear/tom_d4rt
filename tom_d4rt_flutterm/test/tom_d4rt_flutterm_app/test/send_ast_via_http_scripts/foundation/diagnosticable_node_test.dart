import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DiagnosticableNode - wraps values for diagnostics tree.
/// Shows how objects are represented in debug output.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DiagnosticableNode Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Debug Tree Node Structure',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NodeDisplay(
                  name: 'Container',
                  depth: 0,
                  properties: ['width: 100.0', 'height: 50.0', 'color: blue'],
                ),
                _NodeDisplay(
                  name: 'Padding',
                  depth: 1,
                  properties: ['padding: EdgeInsets.all(8.0)'],
                ),
                _NodeDisplay(
                  name: 'Text',
                  depth: 2,
                  properties: ['data: "Hello"', 'style: TextStyle(...)'],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DiagnosticableNode wraps:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• name - node identifier'),
                Text('• value - the wrapped object'),
                Text('• style - how to display in tree'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _NodeDisplay extends StatelessWidget {
  final String name;
  final int depth;
  final List<String> properties;
  const _NodeDisplay({required this.name, required this.depth, required this.properties});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 20.0, top: 8, bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.teal.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
            const SizedBox(height: 4),
            ...properties.map((p) => Text('  \$p', style: const TextStyle(fontSize: 12, fontFamily: 'monospace'))),
          ],
        ),
      ),
    );
  }
}
