import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DiagnosticableTree - abstract tree diagnostics.
/// Shows interface for objects with hierarchical debug output.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DiagnosticableTree Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Hierarchical Debug Interface',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('DiagnosticableTree Interface', style: TextStyle(fontWeight: FontWeight.bold)),
                const Divider(),
                _MethodRow(name: 'toStringShallow()', desc: 'One-line with properties'),
                _MethodRow(name: 'toStringDeep()', desc: 'Multi-line with children'),
                _MethodRow(name: 'toDiagnosticsNode()', desc: 'Get node representation'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Implementors:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  Chip(label: Text('Widget')),
                  Chip(label: Text('RenderObject')),
                  Chip(label: Text('Element')),
                  Chip(label: Text('SemanticsNode')),
                ]),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _MethodRow extends StatelessWidget {
  final String name;
  final String desc;
  const _MethodRow({required this.name, required this.desc});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.purple.shade100, borderRadius: BorderRadius.circular(4)),
            child: Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(desc, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
