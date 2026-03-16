import 'package:flutter/material.dart';

/// Deep visual demo for Selectable
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Selectable')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Selection States', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _StatusCard('none', 'Not selected', Colors.grey),
      _StatusCard('uncollapsed', 'Selection active', Colors.blue),
      _StatusCard('collapsed', 'Cursor only', Colors.green),
    ])),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('SelectionStatus states for selectable widgets', style: TextStyle(fontSize: 11))),
  ])));
}

class _StatusCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _StatusCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.text_fields, color: color), SizedBox(width: 12), Text('SelectionStatus.$name', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')), Spacer(), Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey))]));
}
