import 'package:flutter/material.dart';

/// Deep visual demo for Diagnosticable - base class for debug output.
/// Shows toStringShort, debugFillProperties, and toString methods.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Diagnosticable Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Debug Output Methods',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _OutputCard(
            method: 'toStringShort()',
            output: 'Container',
            description: 'Brief one-line description',
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          _OutputCard(
            method: 'toString()',
            output: 'Container(width: 100, color: blue)',
            description: 'Detailed single-line output',
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _OutputCard(
            method: 'toStringDeep()',
            output: 'Container\n  width: 100.0\n  height: 50.0\n  child: Text',
            description: 'Full tree representation',
            color: Colors.purple,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.lightbulb, color: Colors.amber),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Override debugFillProperties() to add custom properties',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _OutputCard extends StatelessWidget {
  final String method;
  final String output;
  final String description;
  final Color color;
  const _OutputCard({
    required this.method,
    required this.output,
    required this.description,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            method,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              output,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
