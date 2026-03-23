// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// Deep visual demo for OffsetPair.
/// Shows global and local offset pair.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('OffsetPair')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Offset Pair',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Expanded(
                child: _OffsetBox(
                  label: 'global',
                  value: '(256, 384)',
                  desc: 'Screen coordinates',
                  color: Colors.cyan,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _OffsetBox(
                  label: 'local',
                  value: '(100, 150)',
                  desc: 'Widget coordinates',
                  color: Colors.teal,
                ),
              ),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Methods:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• OffsetPair(global, local)'),
                Text('• operator + / -'),
                Text('• OffsetPair.zero'),
                Text('• fromEventPosition / fromEventDelta'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _OffsetBox extends StatelessWidget {
  final String label;
  final String value;
  final String desc;
  final Color color;
  const _OffsetBox({required this.label, required this.value, required this.desc, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
      child: Column(children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontFamily: 'monospace')),
        const SizedBox(height: 4),
        Text(desc, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ]),
    );
  }
}
