import 'package:flutter/material.dart';

/// Deep visual demo for building child semantics configurations
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ConfigurationsResultBuilder')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Building Child Semantics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _NodeBox('Parent', Colors.teal),
        ]),
        SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.account_tree, color: Colors.teal),
        ]),
        SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _NodeBox('Config 1', Colors.blue),
          _NodeBox('Config 2', Colors.orange),
          _NodeBox('Config 3', Colors.purple),
        ]),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Builder Pattern:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('1. Create builder', style: TextStyle(fontSize: 11)),
        Text('2. Add markAsMergeUp() for merged nodes', style: TextStyle(fontSize: 11)),
        Text('3. Add siblingMergeGroups', style: TextStyle(fontSize: 11)),
        Text('4. Build final result', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _NodeBox extends StatelessWidget {
  final String label; final Color color;
  const _NodeBox(this.label, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(4), border: Border.all(color: color)), child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)));
}
