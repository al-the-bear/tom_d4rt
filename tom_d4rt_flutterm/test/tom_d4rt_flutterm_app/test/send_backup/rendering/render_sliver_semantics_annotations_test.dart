import 'package:flutter/material.dart';

/// Deep visual demo for sliver semantics annotations
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Sliver Semantics')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Sliver Semantic Annotations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _AnnotationCard('indexInParent', 'Index in sliver list'),
      _AnnotationCard('scrollExtentMin', 'Minimum scroll extent'),
      _AnnotationCard('scrollExtentMax', 'Maximum scroll extent'),
      _AnnotationCard('scrollPosition', 'Current scroll position'),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Provides accessibility info for scroll regions', style: TextStyle(fontSize: 11))),
  ])));
}

class _AnnotationCard extends StatelessWidget {
  final String name; final String desc;
  const _AnnotationCard(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.accessibility, color: Colors.cyan), SizedBox(width: 8), Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
