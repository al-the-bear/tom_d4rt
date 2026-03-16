import 'package:flutter/material.dart';

/// Deep visual demo for ContainerParentDataMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ContainerParentDataMixin')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Parent Data Linked List', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _Node('null'),
        Icon(Icons.arrow_back, size: 16),
        _Node('Child 1'),
        Icon(Icons.arrow_forward, size: 16),
        _Node('Child 2'),
        Icon(Icons.arrow_forward, size: 16),
        _Node('Child 3'),
        Icon(Icons.arrow_forward, size: 16),
        _Node('null'),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Doubly-linked sibling list:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• previousSibling: ChildType?', style: TextStyle(fontSize: 11)),
        Text('• nextSibling: ChildType?', style: TextStyle(fontSize: 11)),
        SizedBox(height: 8),
        Text('Enables O(1) insert/remove operations', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ])),
  ])));
}

class _Node extends StatelessWidget {
  final String label;
  const _Node(this.label);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.symmetric(horizontal: 2), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: label == 'null' ? Colors.grey.shade300 : Colors.purple.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)));
}
