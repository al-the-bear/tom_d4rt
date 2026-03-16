import 'package:flutter/material.dart';

/// Deep visual demo for TextParentData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Text Parent Data')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('TextParentData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.text_snippet, size: 48, color: Colors.orange),
        SizedBox(height: 12),
        Text('Parent data for text widgets', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        _Field('scale', 'Text scale factor'),
        _Field('offset', 'Position offset'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Used by widgets embedded in text', style: TextStyle(fontSize: 11))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
