import 'package:flutter/material.dart';

/// Deep visual demo for SelectParagraphSelectionEvent
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Select Paragraph')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Icon(Icons.format_align_left, size: 64, color: Colors.teal),
    SizedBox(height: 16),
    Text('SelectParagraphSelectionEvent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text('Triggered by triple-tap', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.teal.shade100, borderRadius: BorderRadius.circular(8)),
          child: Text('This entire paragraph would be selected when you triple-tap anywhere on it.', style: TextStyle(fontSize: 12))),
        SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.touch_app, size: 16, color: Colors.teal),
          Text(' × 3', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ]),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Selects from paragraph start to end', style: TextStyle(fontSize: 11))),
  ])));
}
