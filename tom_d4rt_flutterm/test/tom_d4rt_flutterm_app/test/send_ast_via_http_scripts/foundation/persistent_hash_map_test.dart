import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for PersistentHashMap - immutable hash map.
/// Shows copy-on-write semantics for efficient immutable operations.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PersistentHashMap Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Immutable Hash Map',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Version 1:', style: TextStyle(fontWeight: FontWeight.bold)),
                _MapEntry(mapKey: 'a', mapValue: '1'),
                _MapEntry(mapKey: 'b', mapValue: '2'),
                const SizedBox(height: 12),
                const Row(children: [Expanded(child: Divider()), Text(' put(c, 3) '), Expanded(child: Divider())]),
                const SizedBox(height: 12),
                const Text('Version 2 (new reference):', style: TextStyle(fontWeight: FontWeight.bold)),
                _MapEntry(mapKey: 'a', mapValue: '1', shared: true),
                _MapEntry(mapKey: 'b', mapValue: '2', shared: true),
                _MapEntry(mapKey: 'c', mapValue: '3', isNew: true),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(children: [
              Icon(Icons.eco, color: Colors.green),
              SizedBox(width: 8),
              Expanded(child: Text('Structural sharing: unchanged entries share memory')),
            ]),
          ),
        ],
      ),
    ),
  );
}

class _MapEntry extends StatelessWidget {
  final String mapKey;
  final String mapValue;
  final bool shared;
  final bool isNew;
  const _MapEntry({required this.mapKey, required this.mapValue, this.shared = false, this.isNew = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: isNew ? Colors.green : Colors.indigo, borderRadius: BorderRadius.circular(4)),
          child: Text(mapKey, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        const Text(' → '),
        Text(mapValue, style: const TextStyle(fontFamily: 'monospace')),
        if (shared) const Text(' (shared)', style: TextStyle(fontSize: 10, color: Colors.grey)),
        if (isNew) const Text(' (new)', style: TextStyle(fontSize: 10, color: Colors.green)),
      ]),
    );
  }
}
