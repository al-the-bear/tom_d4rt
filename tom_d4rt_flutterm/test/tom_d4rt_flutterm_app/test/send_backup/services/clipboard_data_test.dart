import 'package:flutter/material.dart';

/// Deep visual demo for ClipboardData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Clipboard Data')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('ClipboardData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.content_paste, size: 48, color: Colors.indigo),
        SizedBox(height: 12),
        Container(padding: EdgeInsets.all(12), width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('ClipboardData(', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
            Text('  text: "Hello World"', style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.green)),
            Text(')', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
          ])),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Container for clipboard text content', style: TextStyle(fontSize: 11))),
  ])));
}
