// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// Deep visual demo for AbstractNode - base class for tree structures.
/// Shows parent-child relationships, depth tracking, and tree traversal.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('AbstractNode Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tree Structure Visualization',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TreeNodeDisplay(label: 'Root', depth: 0, hasChildren: true),
                _TreeNodeDisplay(label: 'Child A', depth: 1, hasChildren: true),
                _TreeNodeDisplay(
                  label: 'Grandchild A1',
                  depth: 2,
                  hasChildren: false,
                ),
                _TreeNodeDisplay(
                  label: 'Grandchild A2',
                  depth: 2,
                  hasChildren: false,
                ),
                _TreeNodeDisplay(
                  label: 'Child B',
                  depth: 1,
                  hasChildren: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AbstractNode Properties:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• parent - reference to parent node'),
                Text('• depth - distance from root'),
                Text('• attached - whether node is in tree'),
                Text('• owner - the tree owner object'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _TreeNodeDisplay extends StatelessWidget {
  final String label;
  final int depth;
  final bool hasChildren;
  const _TreeNodeDisplay({
    required this.label,
    required this.depth,
    required this.hasChildren,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 24.0, top: 4, bottom: 4),
      child: Row(
        children: [
          Icon(
            hasChildren ? Icons.folder : Icons.insert_drive_file,
            size: 20,
            color: hasChildren ? Colors.amber : Colors.blue,
          ),
          const SizedBox(width: 8),
          Text(label),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('depth: \$depth', style: const TextStyle(fontSize: 10)),
          ),
        ],
      ),
    );
  }
}
