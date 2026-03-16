import 'package:flutter/material.dart';

/// Deep visual demo for ExcludeFocusTraversal
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ExcludeFocusTraversal')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('ExcludeFocusTraversal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 8),
    Text('Skip in focus navigation', style: TextStyle(fontSize: 12, color: Colors.grey)),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12)),
      child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.widgets, size: 48, color: Colors.cyan),
        SizedBox(height: 12),
        Text('ExcludeFocusTraversal Demo', style: TextStyle(fontWeight: FontWeight.bold)),
      ])))),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Widget from widgets library', style: TextStyle(fontSize: 10))),
  ])));
}
