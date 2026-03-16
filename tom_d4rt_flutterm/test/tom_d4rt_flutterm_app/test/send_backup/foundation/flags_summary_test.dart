import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for FlagsSummary - combined boolean flags display.
/// Shows how multiple flags are summarized in one property.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('FlagsSummary Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Combined Flags Display',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Widget Flags:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  _FlagChip(label: 'enabled', active: true),
                  _FlagChip(label: 'visible', active: true),
                  _FlagChip(label: 'focused', active: false),
                  _FlagChip(label: 'selected', active: true),
                  _FlagChip(label: 'hovered', active: false),
                ]),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: const Text('flags: enabled, visible, selected', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('FlagsSummary combines multiple boolean properties into a comma-separated list, showing only active flags.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _FlagChip extends StatelessWidget {
  final String label;
  final bool active;
  const _FlagChip({required this.label, required this.active});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: active ? Colors.purple : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(active ? Icons.check : Icons.close, size: 14, color: active ? Colors.white : Colors.grey),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(color: active ? Colors.white : Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
