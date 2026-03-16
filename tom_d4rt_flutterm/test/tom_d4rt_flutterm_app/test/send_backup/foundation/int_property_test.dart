import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for IntProperty - diagnostic property for integers.
/// Shows integer value formatting in debug output.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('IntProperty Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Integer Value Diagnostics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _IntCard(name: 'childCount', value: 5, color: Colors.blue),
          _IntCard(name: 'depth', value: 3, color: Colors.green),
          _IntCard(name: 'index', value: 42, color: Colors.orange),
          _IntCard(name: 'maxLines', value: 2, color: Colors.purple),
          _IntCard(name: 'flex', value: 1, color: Colors.teal),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('IntProperty options:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• defaultValue - skip if equal'),
                Text('• level - visibility level'),
                Text('• showName - display property name'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _IntCard extends StatelessWidget {
  final String name;
  final int value;
  final Color color;
  const _IntCard({required this.name, required this.value, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
            child: Text('\$value', style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
