import 'package:flutter/material.dart';

/// Deep visual demo for pointer events
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Pointer Events')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Pointer Event Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _EventCard('PointerDownEvent', 'Finger/mouse touches surface', Colors.blue),
      _EventCard('PointerMoveEvent', 'Pointer moves while down', Colors.green),
      _EventCard('PointerUpEvent', 'Pointer releases', Colors.orange),
      _EventCard('PointerHoverEvent', 'Mouse moves without pressing', Colors.purple),
      _EventCard('PointerScrollEvent', 'Scroll wheel rotation', Colors.red),
      _EventCard('PointerCancelEvent', 'System cancels gesture', Colors.grey),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('All pointer events inherit from PointerEvent', style: TextStyle(fontSize: 11))),
  ])));
}

class _EventCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _EventCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.touch_app, color: color), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]))]));
}
