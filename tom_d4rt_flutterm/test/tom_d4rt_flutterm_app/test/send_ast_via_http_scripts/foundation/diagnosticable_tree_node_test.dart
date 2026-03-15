import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DiagnosticableTreeNode - node wrapper with children.
/// Shows tree node structure with properties and child nodes.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DiagnosticableTreeNode Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tree Node with Children',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _TreeNodeCard(
            name: 'Container',
            properties: ['width: 200', 'height: 100', 'color: Colors.blue'],
            children: [
              _ChildNode(name: 'Padding', count: 1),
              _ChildNode(name: 'Row', count: 3),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DiagnosticableTreeNode:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• Wraps Diagnosticable objects'),
                Text('• Provides child enumeration'),
                Text('• Used for toStringDeep()'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _TreeNodeCard extends StatelessWidget {
  final String name;
  final List<String> properties;
  final List<_ChildNode> children;
  const _TreeNodeCard({required this.name, required this.properties, required this.children});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_tree, color: Colors.blue),
              const SizedBox(width: 8),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const Divider(),
          const Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ...properties.map((p) => Text('  \$p', style: const TextStyle(fontFamily: 'monospace', fontSize: 12))),
          const SizedBox(height: 12),
          const Text('Children:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ...children,
        ],
      ),
    );
  }
}

class _ChildNode extends StatelessWidget {
  final String name;
  final int count;
  const _ChildNode({required this.name, required this.count});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 4),
      child: Row(
        children: [
          const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
          Text('\$name (\$count)', style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
