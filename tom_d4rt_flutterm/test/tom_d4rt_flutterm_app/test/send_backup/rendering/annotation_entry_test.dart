import 'package:flutter/material.dart';

/// Deep visual demo for AnnotationEntry
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('AnnotationEntry')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Icon(Icons.bookmark, size: 48, color: Colors.purple),
    SizedBox(height: 8),
    Text('Annotation Entry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(children: [
          _Field('annotation', 'T', Colors.blue),
          SizedBox(width: 16),
          _Field('localPosition', 'Offset', Colors.orange),
        ]),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Result of annotation search', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('• annotation: The found annotation data', style: TextStyle(fontSize: 11)),
        Text('• localPosition: Position in layer coordinates', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String type; final Color color;
  const _Field(this.name, this.type, this.color);
  @override Widget build(BuildContext context) => Expanded(child: Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
    child: Column(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold)), Text(type, style: TextStyle(fontSize: 11, color: Colors.grey))])));
}
