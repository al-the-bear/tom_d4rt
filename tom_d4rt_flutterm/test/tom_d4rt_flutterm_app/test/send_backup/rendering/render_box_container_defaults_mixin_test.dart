import 'package:flutter/material.dart';

/// Deep visual demo for RenderBoxContainerDefaultsMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Box Container Mixin')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Container Defaults', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text('Mixin provides default implementations for:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        _MethodCard('defaultPaint', 'Paint all children'),
        _MethodCard('defaultHitTestChildren', 'Hit test all children'),
        _MethodCard('defaultComputeDistanceToFirstActualBaseline', 'Find baseline'),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Used by Row, Column, and other multi-child layouts', style: TextStyle(fontSize: 11))),
  ])));
}

class _MethodCard extends StatelessWidget {
  final String name; final String desc;
  const _MethodCard(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.code, color: Colors.teal, size: 20), SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Text(desc, style: TextStyle(fontSize: 10))]))]));
}
