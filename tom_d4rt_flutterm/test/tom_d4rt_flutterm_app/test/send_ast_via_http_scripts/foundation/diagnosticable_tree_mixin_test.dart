import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DiagnosticableTreeMixin - adds tree structure to diagnostics.
/// Shows how widgets form hierarchical debug output.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DiagnosticableTreeMixin Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Widget Tree Debug Structure',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TreeLine(depth: 0, text: 'MaterialApp', hasChildren: true),
                _TreeLine(depth: 1, text: 'Scaffold', hasChildren: true),
                _TreeLine(depth: 2, text: 'AppBar', hasChildren: true),
                _TreeLine(depth: 3, text: 'Text("Title")', hasChildren: false),
                _TreeLine(depth: 2, text: 'Center', hasChildren: true),
                _TreeLine(depth: 3, text: 'Container', hasChildren: true),
                _TreeLine(depth: 4, text: 'Text("Content")', hasChildren: false),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mixin Methods:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• toStringDeep() - full tree string'),
                Text('• debugDescribeChildren() - child list'),
                Text('• toDiagnosticsNode() - node wrapper'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _TreeLine extends StatelessWidget {
  final int depth;
  final String text;
  final bool hasChildren;
  const _TreeLine({required this.depth, required this.text, required this.hasChildren});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 16.0, top: 2, bottom: 2),
      child: Row(
        children: [
          Text(hasChildren ? '├─ ' : '└─ ', style: const TextStyle(fontFamily: 'monospace', color: Colors.grey)),
          Icon(hasChildren ? Icons.expand_more : Icons.remove, size: 14, color: Colors.indigo),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
        ],
      ),
    );
  }
}
