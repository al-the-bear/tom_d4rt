import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for IterableProperty - diagnostic property for lists.
/// Shows how collections are formatted in debug output.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('IterableProperty Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Collection Diagnostics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _IterableCard(name: 'children', items: ['Text', 'Container', 'Row'], color: Colors.blue),
          const SizedBox(height: 12),
          _IterableCard(name: 'colors', items: ['red', 'green', 'blue', 'yellow', 'purple'], color: Colors.orange),
          const SizedBox(height: 12),
          _IterableCard(name: 'values', items: ['1', '2', '3', '...+7 more'], color: Colors.purple),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('IterableProperty truncates long collections with "...+N more" for readability', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _IterableCard extends StatelessWidget {
  final String name;
  final List<String> items;
  final Color color;
  const _IterableCard({required this.name, required this.items, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('\$name:', style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6, runSpacing: 6,
            children: items.map((item) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
              child: Text(item, style: const TextStyle(fontSize: 12)),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
