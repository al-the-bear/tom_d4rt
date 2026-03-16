import 'package:flutter/material.dart';

/// Deep visual demo for DeltaTextInputClient
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Delta Input')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('DeltaTextInputClient', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.edit_note, size: 48, color: Colors.amber),
        SizedBox(height: 12),
        Text('Incremental Text Updates', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        _Delta('TextEditingDeltaInsertion', 'Text added'),
        _Delta('TextEditingDeltaDeletion', 'Text removed'),
        _Delta('TextEditingDeltaReplacement', 'Text replaced'),
        _Delta('TextEditingDeltaNonTextUpdate', 'Selection/composition'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Efficient text updates via deltas', style: TextStyle(fontSize: 11))),
  ])));
}

class _Delta extends StatelessWidget {
  final String name; final String desc;
  const _Delta(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 9)), Spacer(), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}
