import 'package:flutter/material.dart';

/// Deep visual demo for SelectionEvent base class
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Selection Event')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SelectionEvent Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _EventCard('SelectAllSelectionEvent', 'Select all content', Colors.purple),
      _EventCard('SelectWordSelectionEvent', 'Double-tap word', Colors.blue),
      _EventCard('SelectParagraphSelectionEvent', 'Triple-tap paragraph', Colors.teal),
      _EventCard('SelectionEdgeUpdateEvent', 'Drag to extend', Colors.green),
      _EventCard('ClearSelectionEvent', 'Clear selection', Colors.red),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Base class for all selection events', style: TextStyle(fontSize: 11))),
  ])));
}

class _EventCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _EventCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.touch_app, color: color), SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]))]));
}
