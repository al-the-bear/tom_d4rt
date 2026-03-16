import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for TextTreeRenderer - renders diagnostics tree.
/// Shows converting DiagnosticsNode tree to text output.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('TextTreeRenderer Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Diagnostics Tree Rendering',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Container', style: TextStyle(fontFamily: 'monospace', color: Colors.green, fontSize: 11)),
                Text('├─color: Color(0xFF2196F3)', style: TextStyle(fontFamily: 'monospace', color: Colors.white70, fontSize: 11)),
                Text('├─padding: EdgeInsets.all(16.0)', style: TextStyle(fontFamily: 'monospace', color: Colors.white70, fontSize: 11)),
                Text('├─alignment: center', style: TextStyle(fontFamily: 'monospace', color: Colors.white70, fontSize: 11)),
                Text('└─child: Text', style: TextStyle(fontFamily: 'monospace', color: Colors.cyan, fontSize: 11)),
                Text('  └─data: "Hello"', style: TextStyle(fontFamily: 'monospace', color: Colors.white70, fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(children: [
              Icon(Icons.transform, color: Colors.blue),
              SizedBox(width: 8),
              Expanded(child: Text('TextTreeRenderer converts DiagnosticsNode hierarchies into formatted text')),
            ]),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Uses TextTreeConfiguration to control prefixes, indentation, and line breaks.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}
