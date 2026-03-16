import 'package:flutter/material.dart';

/// Deep visual demo for CrossFadeState
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('CrossFadeState')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('CrossFadeState', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 8),
    Text('State for animated cross fade', style: TextStyle(fontSize: 12, color: Colors.grey)),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.widgets, size: 48, color: Colors.blue),
        SizedBox(height: 12),
        Text('CrossFadeState Demo', style: TextStyle(fontWeight: FontWeight.bold)),
      ])))),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Widget from widgets library', style: TextStyle(fontSize: 10))),
  ])));
}
