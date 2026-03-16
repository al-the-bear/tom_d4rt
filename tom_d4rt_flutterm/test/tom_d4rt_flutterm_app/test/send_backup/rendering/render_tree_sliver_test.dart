import 'package:flutter/material.dart';

/// Deep visual demo for tree sliver rendering
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Tree Sliver')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Tree Structure Sliver', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _TreeNode('Root', 0, true),
      _TreeNode('Child 1', 1, true),
      _TreeNode('Leaf 1.1', 2, false),
      _TreeNode('Leaf 1.2', 2, false),
      _TreeNode('Child 2', 1, true),
      _TreeNode('Leaf 2.1', 2, false),
      _TreeNode('Child 3', 1, false),
    ])),
  ])));
}

class _TreeNode extends StatelessWidget {
  final String name; final int depth; final bool hasChildren;
  const _TreeNode(this.name, this.depth, this.hasChildren);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(left: depth * 24.0, bottom: 4), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.brown.shade50, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Icon(hasChildren ? Icons.folder : Icons.insert_drive_file, size: 16, color: hasChildren ? Colors.brown : Colors.grey), SizedBox(width: 8), Text(name, style: TextStyle(fontWeight: hasChildren ? FontWeight.bold : FontWeight.normal))]));
}
