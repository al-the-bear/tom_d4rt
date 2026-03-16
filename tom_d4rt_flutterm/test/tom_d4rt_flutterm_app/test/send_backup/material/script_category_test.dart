import 'package:flutter/material.dart';

/// Deep visual demo for ScriptCategory enum.
/// Identifies writing system for typography.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ScriptCategory', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            _ScriptRow('englishLike', 'ABC', 'Latin, Cyrillic, Greek'),
            _ScriptRow('dense', '日本語', 'CJK scripts'),
            _ScriptRow('tall', 'العربية', 'Arabic, Hebrew, Thai'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Affects line height and baseline', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ScriptRow extends StatelessWidget {
  final String category;
  final String sample;
  final String scripts;
  const _ScriptRow(this.category, this.sample, this.scripts);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
            child: Text(sample, style: const TextStyle(fontSize: 12)),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category, style: const TextStyle(fontFamily: 'monospace', fontSize: 10)),
              Text(scripts, style: TextStyle(fontSize: 8, color: Colors.grey.shade600)),
            ],
          ),
        ],
      ),
    );
  }
}
