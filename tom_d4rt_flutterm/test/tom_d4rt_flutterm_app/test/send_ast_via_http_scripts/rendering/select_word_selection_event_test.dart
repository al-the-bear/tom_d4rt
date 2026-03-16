import 'package:flutter/material.dart';

/// Deep visual demo for SelectWordSelectionEvent
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Select Word')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Icon(Icons.text_fields, size: 64, color: Colors.blue),
    SizedBox(height: 16),
    Text('SelectWordSelectionEvent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text('Triggered by double-tap', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Double tap a ', style: TextStyle(fontSize: 14)),
          Container(padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2), color: Colors.blue.shade200, child: Text('word', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          Text(' to select', style: TextStyle(fontSize: 14)),
        ]),
        SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.touch_app, size: 16, color: Colors.blue),
          Text(' × 2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ]),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Selects word boundaries using text analysis', style: TextStyle(fontSize: 11))),
  ])));
}
