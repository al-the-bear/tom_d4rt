import 'package:flutter/material.dart';

/// Deep visual demo for PlaceholderSpanIndexSemanticsTag
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Placeholder Semantics')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Inline Widget Semantics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: RichText(text: TextSpan(style: TextStyle(fontSize: 18, color: Colors.black), children: [
        TextSpan(text: 'Click '),
        WidgetSpan(child: Icon(Icons.star, color: Colors.amber)),
        TextSpan(text: ' to rate or '),
        WidgetSpan(child: Icon(Icons.share, color: Colors.blue)),
        TextSpan(text: ' to share'),
      ]))),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Semantics Tag:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Associates placeholder index with semantics', style: TextStyle(fontSize: 11)),
        Text('• Used by screen readers for inline widgets', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
