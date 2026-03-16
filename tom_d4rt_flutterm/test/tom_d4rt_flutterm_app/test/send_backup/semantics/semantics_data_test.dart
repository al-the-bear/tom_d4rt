import 'package:flutter/material.dart';

/// Deep visual demo for SemanticsData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SemanticsData')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Semantics Data Structure', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _DataSection('Identity', [_DataField('label', 'String'), _DataField('value', 'String'), _DataField('hint', 'String')]),
      _DataSection('Flags', [_DataField('flags', 'int bitfield'), _DataField('actions', 'int bitfield')]),
      _DataSection('Geometry', [_DataField('rect', 'Rect'), _DataField('transform', 'Matrix4')]),
      _DataSection('Text', [_DataField('textSelection', 'TextSelection'), _DataField('scrollPosition', 'double')]),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('Immutable data for a single semantics node', style: TextStyle(fontSize: 11))),
  ])));
}

class _DataSection extends StatelessWidget {
  final String title; final List<_DataField> fields;
  const _DataSection(this.title, this.fields);
  @override Widget build(BuildContext context) => Card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(padding: EdgeInsets.all(8), color: Colors.blue.withOpacity(0.1), child: Text(title, style: TextStyle(fontWeight: FontWeight.bold))),
    ...fields,
  ]));
}

class _DataField extends StatelessWidget {
  final String name; final String type;
  const _DataField(this.name, this.type);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    child: Row(children: [Text(name, style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)), Spacer(), Text(type, style: TextStyle(color: Colors.grey, fontSize: 12))]));
}
