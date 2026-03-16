import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// Deep visual demo for DebugSemanticsDumpOrder
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('DebugSemanticsDumpOrder')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Dump Order Options', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 24),
    _OrderCard(DebugSemanticsDumpOrder.traversalOrder, 'Traversal Order', 'Screen reader navigation order', Icons.swap_vert, Colors.blue),
    SizedBox(height: 12),
    _OrderCard(DebugSemanticsDumpOrder.inverseHitTest, 'Inverse Hit Test', 'Top-to-bottom render order', Icons.layers, Colors.orange),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Usage:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('debugDumpSemanticsTree(', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
        Text('  DebugSemanticsDumpOrder.traversalOrder', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
        Text(');', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
      ])),
  ])));
}

class _OrderCard extends StatelessWidget {
  final DebugSemanticsDumpOrder order; final String name; final String desc; final IconData icon; final Color color;
  const _OrderCard(this.order, this.name, this.desc, this.icon, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: color)),
    child: Row(children: [Icon(icon, size: 40, color: color), SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), SizedBox(height: 4), Text(desc, style: TextStyle(color: Colors.grey))]))]));
}
