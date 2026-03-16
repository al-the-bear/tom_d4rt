import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for ObserverList - list optimized for listeners.
/// Shows efficient add/remove during iteration.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ObserverList Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Observer List Management',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Registered Observers:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _ObserverRow(index: 0, name: 'WidgetA.onUpdate'),
                _ObserverRow(index: 1, name: 'WidgetB.onUpdate'),
                _ObserverRow(index: 2, name: 'Logger.onUpdate'),
                const SizedBox(height: 12),
                Row(children: [
                  ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, size: 16), label: const Text('Add'), style: ElevatedButton.styleFrom(visualDensity: VisualDensity.compact)),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.remove, size: 16), label: const Text('Remove'), style: ElevatedButton.styleFrom(visualDensity: VisualDensity.compact, backgroundColor: Colors.red)),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(children: [
              Icon(Icons.flash_on, color: Colors.amber),
              SizedBox(width: 8),
              Expanded(child: Text('ObserverList allows safe modification during iteration')),
            ]),
          ),
        ],
      ),
    ),
  );
}

class _ObserverRow extends StatelessWidget {
  final int index;
  final String name;
  const _ObserverRow({required this.index, required this.name});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Container(
          width: 24, height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(4)),
          child: Text('\$index', style: const TextStyle(color: Colors.white, fontSize: 11)),
        ),
        const SizedBox(width: 12),
        const Icon(Icons.hearing, size: 16, color: Colors.teal),
        const SizedBox(width: 8),
        Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
      ]),
    );
  }
}
