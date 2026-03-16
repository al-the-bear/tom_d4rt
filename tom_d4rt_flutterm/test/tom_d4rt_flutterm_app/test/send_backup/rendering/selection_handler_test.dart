import 'package:flutter/material.dart';

/// Deep visual demo for SelectionHandler
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Selection Handler')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SelectionHandler Mixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.deepPurple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.pan_tool, size: 48, color: Colors.deepPurple),
        SizedBox(height: 12),
        Text('Methods to implement:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        _Method('dispatchSelectionEvent', 'Handle selection event'),
        _Method('getSelectionGeometry', 'Return current geometry'),
        _Method('pushHandleLayers', 'Add handle layers'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Mixin for custom selectable renderObjects', style: TextStyle(fontSize: 11))),
  ])));
}

class _Method extends StatelessWidget {
  final String name; final String desc;
  const _Method(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
