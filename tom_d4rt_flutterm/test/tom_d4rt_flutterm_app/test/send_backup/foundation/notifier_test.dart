import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for ChangeNotifier - observable state pattern.
/// Shows listener registration, notification, and disposal.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ChangeNotifier Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Observable State Pattern',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(8)),
                  child: const Column(children: [Icon(Icons.notifications_active, color: Colors.white, size: 32), Text('ChangeNotifier', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
                ),
                const SizedBox(height: 16),
                const Text('notifyListeners()', style: TextStyle(fontFamily: 'monospace')),
                const Icon(Icons.arrow_downward),
                const SizedBox(height: 8),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  _ListenerChip(label: 'Widget A'),
                  _ListenerChip(label: 'Widget B'),
                  _ListenerChip(label: 'Widget C'),
                ]),
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
                Text('Lifecycle:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('1. addListener() - subscribe'),
                Text('2. notifyListeners() - broadcast'),
                Text('3. removeListener() - unsubscribe'),
                Text('4. dispose() - cleanup'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _ListenerChip extends StatelessWidget {
  final String label;
  const _ListenerChip({required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.purple)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.hearing, size: 16, color: Colors.purple), const SizedBox(width: 4), Text(label, style: const TextStyle(fontSize: 12))]),
    );
  }
}
