import 'package:flutter/material.dart';

/// Deep visual demo for DefaultTextEditingShortcuts
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('DefaultTextEditingShortcuts')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('DefaultTextEditingShortcuts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 8),
    Text('Text editing keyboard shortcuts', style: TextStyle(fontSize: 12, color: Colors.grey)),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
      child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.widgets, size: 48, color: Colors.green),
        SizedBox(height: 12),
        Text('DefaultTextEditingShortcuts Demo', style: TextStyle(fontWeight: FontWeight.bold)),
      ])))),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Widget from widgets library', style: TextStyle(fontSize: 10))),
  ])));
}
