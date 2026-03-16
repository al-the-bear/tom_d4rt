import 'package:flutter/material.dart';

/// Deep visual demo for WordBoundary
dynamic build(BuildContext context) {
  const text = 'Hello World Flutter Demo';
  final words = text.split(' ');
  return Scaffold(appBar: AppBar(title: Text('WordBoundary Demo')), body: Padding(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('Text: "$text"', style: TextStyle(fontWeight: FontWeight.bold)),
    SizedBox(height: 16),
    Text('Word Boundaries:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
    SizedBox(height: 8),
    Wrap(spacing: 8, runSpacing: 8, children: [
      for (int i = 0; i < words.length; i++)
        Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(4)),
          child: Column(children: [Text('Word $i', style: TextStyle(fontSize: 10, color: Colors.grey)), Text(words[i], style: TextStyle(fontWeight: FontWeight.bold))]))
    ]),
    SizedBox(height: 24),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('WordBoundary Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• start: int - start index', style: TextStyle(fontSize: 12)),
        Text('• end: int - end index (exclusive)', style: TextStyle(fontSize: 12)),
      ]))
  ])));
}
