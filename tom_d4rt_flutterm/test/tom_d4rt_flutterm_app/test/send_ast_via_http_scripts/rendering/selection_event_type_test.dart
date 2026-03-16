import 'package:flutter/material.dart';

/// Deep visual demo for SelectionEventType enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Event Type')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SelectionEventType', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _TypeCard('startEdgeUpdate', 'Drag from start edge', Colors.green, Icons.chevron_left),
    _TypeCard('endEdgeUpdate', 'Drag from end edge', Colors.blue, Icons.chevron_right),
    _TypeCard('clear', 'Clear selection', Colors.red, Icons.clear),
    _TypeCard('selectAll', 'Select all', Colors.purple, Icons.select_all),
    _TypeCard('selectWord', 'Word selection', Colors.orange, Icons.text_fields),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Enum for categorizing selection events', style: TextStyle(fontSize: 11))),
  ])));
}

class _TypeCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color; final IconData icon;
  const _TypeCard(this.name, this.desc, this.color, this.icon);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(icon, color: color), SizedBox(width: 8), Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
