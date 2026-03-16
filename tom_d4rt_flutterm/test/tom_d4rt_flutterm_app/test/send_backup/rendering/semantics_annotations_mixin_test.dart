import 'package:flutter/material.dart';

/// Deep visual demo for SemanticsAnnotationsMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Semantics Mixin')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SemanticsAnnotationsMixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.accessibility_new, size: 48, color: Colors.indigo),
        SizedBox(height: 12),
        Text('Mixin Methods', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        _Method('describeSemanticsConfiguration', 'Set semantic properties'),
        _Method('assembleSemanticsNode', 'Build semantic tree'),
        _Method('clearSemantics', 'Remove semantic info'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Add accessibility info to RenderObjects', style: TextStyle(fontSize: 11))),
  ])));
}

class _Method extends StatelessWidget {
  final String name; final String desc;
  const _Method(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 9)), Spacer(), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}
