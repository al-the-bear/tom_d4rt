import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DiagnosticsTreeStyle - controls tree output format.
/// Shows different visual styles for diagnostic trees.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DiagnosticsTreeStyle Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tree Output Styles',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _StyleCard(style: 'sparse', desc: 'Minimal connectors', example: 'Widget\n  child: Text', color: Colors.blue),
          _StyleCard(style: 'dense', desc: 'Compact output', example: 'Widget(child: Text)', color: Colors.green),
          _StyleCard(style: 'offstage', desc: 'Hidden from view', example: '(offstage)', color: Colors.grey),
          _StyleCard(style: 'whitespace', desc: 'Indentation only', example: 'Widget\n    Text', color: Colors.purple),
          _StyleCard(style: 'flat', desc: 'No hierarchy', example: 'Widget, Text', color: Colors.orange),
          _StyleCard(style: 'singleLine', desc: 'One line', example: 'Widget { child: Text }', color: Colors.teal),
          _StyleCard(style: 'shallow', desc: 'Truncated depth', example: 'Widget(...)...', color: Colors.pink),
          _StyleCard(style: 'truncateChildren', desc: 'Limited children', example: 'List [...4 more]', color: Colors.indigo),
        ],
      ),
    ),
  );
}

class _StyleCard extends StatelessWidget {
  final String style;
  final String desc;
  final String example;
  final Color color;
  const _StyleCard({required this.style, required this.desc, required this.example, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(width: 90, child: Text(style, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 12))),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(desc, style: const TextStyle(fontSize: 11)),
                Text(example, style: const TextStyle(fontFamily: 'monospace', fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
