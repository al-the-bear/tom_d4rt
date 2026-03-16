import 'package:flutter/material.dart';

/// Deep visual demo for AndroidViewController
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Android View')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('AndroidViewController', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.android, size: 48, color: Colors.green),
        SizedBox(height: 12),
        Text('Native Android View Manager', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        _Method('create', 'Create platform view'),
        _Method('setSize', 'Update view dimensions'),
        _Method('setOffset', 'Update view position'),
        _Method('dispose', 'Release native resources'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Controls Android native view lifecycle', style: TextStyle(fontSize: 11))),
  ])));
}

class _Method extends StatelessWidget {
  final String name; final String desc;
  const _Method(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
