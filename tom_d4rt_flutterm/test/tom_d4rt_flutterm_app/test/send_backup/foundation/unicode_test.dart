import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for Unicode constants - character utilities.
/// Shows special Unicode characters used in Flutter.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Unicode Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Unicode Constants',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _UnicodeRow(name: 'LRE', code: 'U+202A', desc: 'Left-to-Right Embedding'),
          _UnicodeRow(name: 'RLE', code: 'U+202B', desc: 'Right-to-Left Embedding'),
          _UnicodeRow(name: 'PDF', code: 'U+202C', desc: 'Pop Directional Formatting'),
          _UnicodeRow(name: 'LRO', code: 'U+202D', desc: 'Left-to-Right Override'),
          _UnicodeRow(name: 'RLO', code: 'U+202E', desc: 'Right-to-Left Override'),
          _UnicodeRow(name: 'LRI', code: 'U+2066', desc: 'Left-to-Right Isolate'),
          _UnicodeRow(name: 'RLI', code: 'U+2067', desc: 'Right-to-Left Isolate'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text('These characters control text directionality for bidirectional (BiDi) text rendering.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _UnicodeRow extends StatelessWidget {
  final String name;
  final String code;
  final String desc;
  const _UnicodeRow({required this.name, required this.code, required this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Container(
          width: 50,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(4)),
          child: Text(name, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
        ),
        const SizedBox(width: 12),
        Text(code, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
        const SizedBox(width: 12),
        Expanded(child: Text(desc, style: const TextStyle(fontSize: 12))),
      ]),
    );
  }
}
