import 'package:flutter/material.dart';

/// Deep visual demo for SliverMultiBoxAdaptorParentData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Multi Box Data')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SliverMultiBoxAdaptorParentData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text('List Item Parent Data', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        _Field('index', 'int - Position in list'),
        _Field('keepAlive', 'bool - Preserve state'),
        _Field('layoutOffset', 'double - Position in scroll'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Used by SliverList and SliverGrid children', style: TextStyle(fontSize: 11))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
