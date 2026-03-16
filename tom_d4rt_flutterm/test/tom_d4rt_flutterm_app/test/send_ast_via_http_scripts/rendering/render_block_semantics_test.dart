import 'package:flutter/material.dart';

/// Deep visual demo for RenderBlockSemantics
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Block Semantics')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Semantics Blocking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.red)),
      child: BlockSemantics(child: Column(children: [
        Icon(Icons.block, size: 48, color: Colors.red),
        SizedBox(height: 8),
        Text('Content below is blocked from semantics tree', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Useful for dialogs and modals', style: TextStyle(fontSize: 12, color: Colors.grey)),
      ]))),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text('This content is behind', style: TextStyle(color: Colors.grey)),
        Text('Not accessible when blocked', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('BlockSemantics prevents screen readers from accessing content behind it', style: TextStyle(fontSize: 11))),
  ])));
}
