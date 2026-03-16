import 'package:flutter/material.dart';

/// Deep visual demo for RenderSemanticsAnnotations
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Semantics Annotations')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Semantic Properties', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _AnnotationCard('label', 'Accessible name', Colors.blue),
      _AnnotationCard('hint', 'Usage instruction', Colors.green),
      _AnnotationCard('value', 'Current value', Colors.orange),
      _AnnotationCard('tooltip', 'Hover tooltip', Colors.purple),
      _AnnotationCard('isButton', 'Button trait', Colors.red),
      _AnnotationCard('isHeader', 'Header trait', Colors.teal),
      _AnnotationCard('isSelected', 'Selection state', Colors.indigo),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Annotations expose widget purpose to assistive tech', style: TextStyle(fontSize: 11))),
  ])));
}

class _AnnotationCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _AnnotationCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 6), padding: EdgeInsets.all(10), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.accessibility, color: color, size: 20), SizedBox(width: 8), Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
