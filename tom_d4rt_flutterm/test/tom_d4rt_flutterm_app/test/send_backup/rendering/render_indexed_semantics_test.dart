import 'package:flutter/material.dart';

/// Deep visual demo for RenderIndexedSemantics
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Indexed Semantics')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Semantics with Index', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView.builder(itemCount: 10, itemBuilder: (_, i) => IndexedSemantics(index: i,
      child: Container(margin: EdgeInsets.symmetric(vertical: 4), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.teal)),
        child: Row(children: [CircleAvatar(backgroundColor: Colors.teal, radius: 16, child: Text('${i + 1}', style: TextStyle(color: Colors.white))), SizedBox(width: 12), Text('List item ${i + 1}', style: TextStyle(fontWeight: FontWeight.bold)), Spacer(), Text('Index: $i', style: TextStyle(fontSize: 11, color: Colors.grey))]))))),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Provides index information to screen readers for ordered content', style: TextStyle(fontSize: 11))),
  ])));
}
