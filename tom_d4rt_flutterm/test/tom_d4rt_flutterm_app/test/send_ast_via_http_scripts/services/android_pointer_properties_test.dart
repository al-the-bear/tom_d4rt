import 'package:flutter/material.dart';

/// Deep visual demo for AndroidPointerProperties
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Pointer Props')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('AndroidPointerProperties', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.touch_app, size: 48, color: Colors.teal),
        SizedBox(height: 12),
        _Field('id', 'Pointer identifier'),
        _Field('toolType', 'Input tool type'),
      ])),
    SizedBox(height: 16),
    Text('Tool Types:', style: TextStyle(fontWeight: FontWeight.bold)),
    SizedBox(height: 8),
    Wrap(spacing: 8, runSpacing: 8, children: [
      _Chip('finger', Colors.blue),
      _Chip('stylus', Colors.green),
      _Chip('mouse', Colors.orange),
      _Chip('eraser', Colors.red),
    ]),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Identifies which pointer/tool is active', style: TextStyle(fontSize: 11))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}

class _Chip extends StatelessWidget {
  final String label; final MaterialColor color;
  const _Chip(this.label, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: color.shade100, borderRadius: BorderRadius.circular(16)),
    child: Text(label, style: TextStyle(fontSize: 11)));
}
