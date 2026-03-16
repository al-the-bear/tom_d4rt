import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for Factory - widget creation factory pattern.
/// Shows how factories create instances on demand.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Factory Pattern Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Factory Widget Creation',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(8)),
                      child: const Column(children: [Icon(Icons.factory, color: Colors.white, size: 32), Text('Factory', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Icon(Icons.arrow_downward, color: Colors.indigo),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _InstanceChip(label: 'Instance 1', color: Colors.blue),
                    _InstanceChip(label: 'Instance 2', color: Colors.green),
                    _InstanceChip(label: 'Instance 3', color: Colors.orange),
                  ],
                ),
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
                Text('Factory<T> usage:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Factory(() => MyWidget())', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                SizedBox(height: 4),
                Text('Creates new instance each call via factory.constructor()', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _InstanceChip extends StatelessWidget {
  final String label;
  final Color color;
  const _InstanceChip({required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20), border: Border.all(color: color)),
      child: Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold)),
    );
  }
}
