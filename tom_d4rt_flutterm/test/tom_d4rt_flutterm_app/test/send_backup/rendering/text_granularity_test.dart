import 'package:flutter/material.dart';

/// Deep visual demo for TextGranularity enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Text Granularity')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('TextGranularity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _GranCard('character', 'Single character', 'H', Colors.blue),
    _GranCard('word', 'Whole words', 'Hello', Colors.green),
    _GranCard('line', 'Entire lines', 'Hello World!', Colors.orange),
    _GranCard('document', 'Full document', 'All text...', Colors.red),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Defines selection movement granularity', style: TextStyle(fontSize: 11))),
  ])));
}

class _GranCard extends StatelessWidget {
  final String name; final String desc; final String example; final MaterialColor color;
  const _GranCard(this.name, this.desc, this.example, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [
      Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: color.shade200, borderRadius: BorderRadius.circular(4)),
        child: Text(example, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11))),
      SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))])),
    ]));
}
