import 'package:flutter/material.dart';

/// Deep visual demo for SelectionEdgeUpdateEvent
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Edge Update')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SelectionEdgeUpdateEvent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Row(children: [
      Expanded(child: _EdgeCard('Start', Icons.first_page, Colors.green)),
      SizedBox(width: 8),
      Expanded(child: _EdgeCard('End', Icons.last_page, Colors.blue)),
    ]),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(children: [
        _Field('globalPosition', 'Offset - Global pointer pos'),
        _Field('granularity', 'Character/Word/Line'),
      ])),
    Spacer(),
    Text('Fired when selection edge moves via drag', style: TextStyle(fontSize: 11, color: Colors.grey)),
  ])));
}

class _EdgeCard extends StatelessWidget {
  final String label; final IconData icon; final MaterialColor color;
  const _EdgeCard(this.label, this.icon, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12)),
    child: Column(children: [Icon(icon, size: 32, color: color), SizedBox(height: 8), Text(label, style: TextStyle(fontWeight: FontWeight.bold))]));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
