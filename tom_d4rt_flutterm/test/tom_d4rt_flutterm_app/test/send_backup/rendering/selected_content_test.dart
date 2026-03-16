import 'package:flutter/material.dart';

/// Deep visual demo for SelectedContent
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Selected Content')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SelectedContent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.lightBlue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.content_copy, size: 48, color: Colors.lightBlue),
        SizedBox(height: 12),
        Text('Container for Selected Text', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(children: [
            _Field('plainText', 'Selected plain text'),
            _Field('geometry', 'Selection geometry'),
          ])),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Holds content copied from SelectionContainer', style: TextStyle(fontSize: 11))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
