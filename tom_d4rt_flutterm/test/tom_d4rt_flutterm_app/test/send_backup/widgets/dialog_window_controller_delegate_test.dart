import 'package:flutter/material.dart';

/// Deep visual demo for DialogWindowControllerDelegate
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('DialogWindowController')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Dialog Window Controller', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.open_in_new, size: 48, color: Colors.indigo),
        SizedBox(height: 12),
        Text('Dialog Window Delegate', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Controls dialog window behavior', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Part of multi-window Flutter API', style: TextStyle(fontSize: 10))),
  ])));
}
