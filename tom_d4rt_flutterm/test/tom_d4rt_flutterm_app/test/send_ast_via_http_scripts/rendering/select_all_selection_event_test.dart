import 'package:flutter/material.dart';

/// Deep visual demo for SelectAllSelectionEvent
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Select All Event')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Icon(Icons.select_all, size: 64, color: Colors.purple),
    SizedBox(height: 16),
    Text('SelectAllSelectionEvent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text('Triggered by Ctrl+A or Select All menu', style: TextStyle(fontSize: 12)),
        SizedBox(height: 12),
        Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(children: [Icon(Icons.keyboard, size: 20, color: Colors.purple), SizedBox(width: 8), Text('⌘/Ctrl + A', style: TextStyle(fontFamily: 'monospace', fontSize: 14))])),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Selects all selectable content in container', style: TextStyle(fontSize: 11))),
  ])));
}
