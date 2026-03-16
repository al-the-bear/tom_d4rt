import 'package:flutter/material.dart';

/// Deep visual demo for SelectedContentRange
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Content Range')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SelectedContentRange', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _RangeVisual(),
        SizedBox(height: 16),
        _Field('startOffset', 'int - Start position'),
        _Field('endOffset', 'int - End position'),
        _Field('plainText', 'String - Selected text'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Represents selection bounds within content', style: TextStyle(fontSize: 11))),
  ])));
}

class _RangeVisual extends StatelessWidget {
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Text('Hello ', style: TextStyle(fontSize: 16)), Container(padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2), color: Colors.amber.shade200, child: Text('selected', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))), Text(' world', style: TextStyle(fontSize: 16))]));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
