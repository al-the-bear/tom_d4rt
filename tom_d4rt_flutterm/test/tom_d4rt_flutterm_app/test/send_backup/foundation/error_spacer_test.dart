import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for ErrorSpacer - blank line in error output.
/// Shows how errors are visually separated for readability.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ErrorSpacer Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Error Output Formatting',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.red.shade200)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('═══ FLUTTER ERROR ═══', style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, color: Colors.red)),
                const SizedBox(height: 8),
                const Text('RenderFlex children have non-zero flex...', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                const SizedBox(height: 16),
                Container(height: 1, color: Colors.red.shade200),
                const SizedBox(height: 4),
                const Center(child: Text('← ErrorSpacer →', style: TextStyle(color: Colors.grey, fontSize: 10))),
                const SizedBox(height: 4),
                Container(height: 1, color: Colors.red.shade200),
                const SizedBox(height: 16),
                const Text('The relevant error-causing widget was:', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                const Text('  Row', style: TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(
              children: [
                Icon(Icons.lightbulb, color: Colors.amber),
                SizedBox(width: 8),
                Expanded(child: Text('ErrorSpacer improves readability by adding blank lines between error sections')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
