import 'package:flutter/material.dart';

/// Deep visual demo for text selection clearing event
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ClearSelectionEvent')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Selection Clear Event', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        RichText(text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 16), children: [
          TextSpan(text: 'Hello '),
          TextSpan(text: 'selected', style: TextStyle(backgroundColor: Colors.blue.shade200)),
          TextSpan(text: ' World'),
        ])),
        SizedBox(height: 12),
        Icon(Icons.arrow_downward, color: Colors.grey),
        SizedBox(height: 8),
        Text('Hello World', style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Text('Selection cleared!', style: TextStyle(color: Colors.grey)),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Dispatched when:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• User taps outside selection', style: TextStyle(fontSize: 11)),
        Text('• Focus moves away', style: TextStyle(fontSize: 11)),
        Text('• Programmatic clear', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
