import 'package:flutter/material.dart';

/// Deep visual demo for SelectionStatus enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Selection Status')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SelectionStatus', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _StatusCard('uncollapsed', 'Text is selected (range)', Colors.green, Icons.text_snippet),
    _StatusCard('collapsed', 'Cursor only (no range)', Colors.orange, Icons.edit),
    _StatusCard('none', 'No selection active', Colors.grey, Icons.block),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(children: [
        Text('Part of SelectionGeometry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
        SizedBox(height: 4),
        Text('Indicates the current selection state', style: TextStyle(fontSize: 10, color: Colors.grey)),
      ])),
  ])));
}

class _StatusCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color; final IconData icon;
  const _StatusCard(this.name, this.desc, this.color, this.icon);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12)),
    child: Row(children: [Icon(icon, size: 32, color: color), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 14)), Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey))]))]));
}
