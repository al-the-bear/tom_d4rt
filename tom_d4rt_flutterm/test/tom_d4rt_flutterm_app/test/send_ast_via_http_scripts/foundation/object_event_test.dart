import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for ObjectEvent - base class for memory events.
/// Shows common event interface for created/disposed tracking.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ObjectEvent Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Memory Event Hierarchy',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                  child: const Text('ObjectEvent', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(width: 50, height: 1, color: Colors.blue),
                  const Text(' extends ', style: TextStyle(color: Colors.grey, fontSize: 11)),
                  Container(width: 50, height: 1, color: Colors.blue),
                ]),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  _EventTypeBox(name: 'ObjectCreated', icon: Icons.add_circle, color: Colors.green),
                  _EventTypeBox(name: 'ObjectDisposed', icon: Icons.remove_circle, color: Colors.red),
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
                Text('Common Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• object - the tracked object'),
                Text('• library - source library URI'),
                Text('• className - object class name'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _EventTypeBox extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  const _EventTypeBox({required this.name, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
      child: Column(children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(name, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold)),
      ]),
    );
  }
}
