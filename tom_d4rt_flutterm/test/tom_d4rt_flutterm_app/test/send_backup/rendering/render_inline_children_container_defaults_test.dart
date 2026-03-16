import 'package:flutter/material.dart';

/// Deep visual demo for inline children container defaults
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Inline Children')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Inline Widget Children', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.lime.shade50, borderRadius: BorderRadius.circular(12)),
      child: RichText(text: TextSpan(style: TextStyle(fontSize: 20, color: Colors.black), children: [
        TextSpan(text: 'Text with '),
        WidgetSpan(child: Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.lime, borderRadius: BorderRadius.circular(4)), child: Text('inline', style: TextStyle(color: Colors.white)))),
        TextSpan(text: ' widgets '),
        WidgetSpan(child: Icon(Icons.star, color: Colors.amber)),
        TextSpan(text: ' inside.'),
      ]))),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Container defaults for:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• WidgetSpan positioning', style: TextStyle(fontSize: 11)),
        Text('• Baseline alignment', style: TextStyle(fontSize: 11)),
        Text('• Hit testing inline widgets', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
